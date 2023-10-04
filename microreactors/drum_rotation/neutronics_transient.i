# Hexagon math
r = ${fparse 16.1765 / 100} # Apothem (set by generator)
d = ${fparse 4 / sqrt(3) * r} # Long diagonal
x_center = ${fparse 9 / 4 * d}
y_center = ${fparse r}

# Rotation specs
angle_step = ${fparse 360 / 1800} # Angular distance between elements in drum
dstep = 6 # Number of elements to pass each timestep
pos_start = 90 # Starting position
t_out = 2 # Time moving outward
speed = 20 # Degrees per second

[Mesh]
  [main]
    type = FileMeshGenerator
    file = empire_2d_CD_fine_in.e
  []
  [coarse_mesh]
    type = FileMeshGenerator
    file = empire_2d_CD_coarse_in.e
  []
  [mesh]
    type = CoarseMeshExtraElementIDGenerator
    input = main
    coarse_mesh = coarse_mesh
    extra_element_id_name = coarse_element_id
  []
[]

[PowerDensity]
  power = ${fparse 2e6 / 12 / 2} # power: 2e6 W / 12 / 2 m (axial)
  power_density_variable = power_density
  integrated_power_postprocessor = integrated_power
[]

[TransportSystems]
  equation_type = transient
  particle = neutron
  G = 11

  ReflectingBoundary = 'bottom topleft'
  VacuumBoundary = 'right'

  [sn]
    scheme = DFEM-SN
    n_delay_groups = 6
    family = MONOMIAL
    order = FIRST
    AQtype = Gauss-Chebyshev
    NPolar = 1 # use >=2 for final runs (4 sawtooth nodes sufficient)
    NAzmthl = 3 # use >=6 for final runs (4 sawtooth nodes sufficient)
    NA = 1
    dnp_amp_scheme = quadrature
    sweep_type = asynchronous_parallel_sweeper
    using_array_variable = true
    collapse_scattering  = true
    hide_angular_flux = true
    hide_higher_flux_moment = 0
  []
[]

[AuxVariables]
  [Tfuel] # fuel temperature
  []
  [Tmod] # moderator + monolith + HP + reflector temperature
  []
  [CD] # drum angle (0 = fully in, 180 = fully out)
  []
[]

[Functions]
  [offset]
    type = ConstantFunction
    value = 225
  []
  [drum_linear]
    type = ParsedFunction
    expression = 'if(t <= t_out, pos_start + speed * t, (pos_start + speed * t_out) - speed * (t - t_out))'
    symbol_names = 't_out pos_start speed'
    symbol_values = '${t_out} ${pos_start} ${speed}'
  []
  [drum_position]
    type = ParsedFunction
    expression = 'if(drum_linear < 0, 0, if(drum_linear > 180, 180, drum_linear))'
    symbol_names = 'drum_linear'
    symbol_values = 'drum_linear'
  []
  [drum_fun]
    type = ParsedFunction
    expression = 'drum_position + offset'
    symbol_names = 'drum_position offset'
    symbol_values = 'drum_position offset'
  []
[]

[ICs]
  [CD_ic]
    type = FunctionIC
    variable = CD
    function = drum_position
  []
[]

[AuxKernels]
  [CD_aux]
    type = FunctionAux
    variable = CD
    function = drum_position
    execute_on = 'initial timestep_begin'
  []
[]

[GlobalParams]
  library_file = empire_core_modified_11G_CD.xml
  library_name = empire_core_modified_11G_CD
  densities = 1.0
  isotopes = 'pseudo'
  dbgmat = false
  grid_names = 'Tfuel Tmod CD'
  grid_variables = 'Tfuel Tmod CD'
  is_meter = true
[]

[Materials]
  [fuel]
    type = CoupledFeedbackNeutronicsMaterial
    block = '1 2' # fuel pin with 1 cm outer radius, no gap
    material_id = 1001
    plus = true
  []
  [moderator]
    type = CoupledFeedbackNeutronicsMaterial
    block = '3 4 5' # moderator pin with 0.975 cm outer radius
    material_id = 1002
  []
  [monolith]
    type = CoupledFeedbackNeutronicsMaterial
    block = '8'
    material_id = 1003
  []
  [hpipe]
    type = CoupledFeedbackNeutronicsMaterial
    block = '6 7' # gap homogenized with HP
    material_id = 1004
  []
  [be]
    type = CoupledFeedbackNeutronicsMaterial
    block = '10 11 14 15'
    material_id = 1005
  []
  [drum]
    type = CoupledFeedbackRoddedNeutronicsMaterial
    block = '13'
    front_position_function = drum_fun
    rotation_center = '${x_center} ${y_center} 0'
    rod_segment_length = '270 90'
    segment_material_ids = '1005 1006'
    isotopes = 'pseudo; pseudo'
    densities = '1.0 1.0'
  []
  [air]
    type = CoupledFeedbackNeutronicsMaterial
    block = '20 21 22'
    material_id = 1007
  []
[]

[Debug]
  show_rodded_materials_average_segment_in = segment_id
[]

[Executioner]
  type = IQSSweepUpdate
  pke_param_csv = true
  output_micro_csv = true

  end_time = 5
  dt = ${fparse angle_step / speed * dstep}
  dtmin = 0.001

  richardson_rel_tol = 1e-4
  richardson_abs_tol = 5e-5
  richardson_max_its = 200
  richardson_value = integrated_power
  inner_solve_type = GMRes
  max_inner_its = 2

  cmfd_acceleration = true
  coarse_element_id = coarse_element_id
  prolongation_type = multiplicative
  max_diffusion_coefficient = 1
[]

[MultiApps]
  [bison]
    type = TransientMultiApp
    input_files = thermal_transient.i
    execute_on = 'timestep_end'
  []
[]

[Transfers]
  [pdens_to_modules]
    type = MultiAppCopyTransfer
    to_multi_app = bison
    source_variable = power_density
    variable = power_density
  []
  [dp_to_modules]
    type = MultiAppReporterTransfer
    to_multi_app = bison
    from_reporters = dp/value
    to_reporters = drum_position/value
  []
  [tfuel_from_modules]
    type = MultiAppGeneralFieldNearestLocationTransfer
    from_multi_app = bison
    variable = Tfuel
    source_variable = Tsolid
    from_blocks = '1 2'
    search_value_conflicts = false
  []
  [tmod_from_modules]
    type = MultiAppGeneralFieldNearestLocationTransfer
    from_multi_app = bison
    variable = Tmod
    source_variable = Tsolid
    from_blocks = '3 4 8 10 11 13 14 15 22'
    search_value_conflicts = false
  []
[]

[Postprocessors]
  [dp]
    type = FunctionValuePostprocessor
    function = drum_position
    execute_on = 'initial linear timestep_end'
  []
[]

[UserObjects]
  [neutronics_initial]
    type = TransportSolutionVectorFile
    transport_system = sn
    folder = 'binary_90'
    writing = false
    execute_on = initial
  []
  [neutronics_adjoint]
    type = TransportSolutionVectorFile
    folder = 'binary_90'
    transport_system = sn
    writing = false
    load_to_adjoint = true
    disable_eigenvalue_transfer = true
    execute_on = initial
  []
  [neutronics_thermal_initial]
    type = SolutionVectorFile
    var = 'Tfuel Tmod'
    folder = 'binary_90'
    writing = false
    execute_on = initial
  []
[]

[Outputs]
  csv = true
  exodus = true
  [console]
    type = Console
    outlier_variable_norms = false
  []
  [pgraph]
    type = PerfGraphOutput
    level = 2
  []
[]
