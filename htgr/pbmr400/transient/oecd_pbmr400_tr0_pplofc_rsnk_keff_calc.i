# ==============================================================================
# PBMR-400 steady-state phase 1 exercise 3, NEA/NSC/DOC(2013)10.
# MASTER0 Neutron kinetic model, T_fuel and T_mod feedback supplied by TH subapp.
# FENIX input file
# ------------------------------------------------------------------------------
# Idaho Falls, INL, 02/22/2020
# Author(s): Dr. Javier Ortensi, Dr. Paolo Balestra, Dr Sebastian Schunert
# ==============================================================================
# - This input may only be run after a checkpoint has been generated with the
# steady state input (for the fluid flow)
# - all units in meters
# - The cross section files are stored using git lfs
# ==============================================================================
# MODEL PARAMETERS
# ==============================================================================
# Define Blocks ----------------------------------------------------------------
fuel_block = '  1   2   3   4   5   6   7   8   9   10
               11  12  13  14  15  16  17  18  19   20
               21  22  23  24  25  26  27  28  29   30
               31  32  33  34  35  36  37  38  39   40
               41  42  43  44  45  46  47  48  49   50
               51  52  53  54  55  56  57  58  59   60
               61  62  63  64  65  66  67  68  69   70
               71  72  73  74  75  76  77  78  79   80
               81  82  83  84  85  86  87  88  89   90
               91  92  93  94  95  96  97  98  99  100
              101 102 103 104 105 106 107 108 109  110'

ref_block = '112 113 114 115 116 117 118 119 120 121 122
             123 124 125 126 127 128 129 130 131 132 133 134
             135 136 137 138 139 140 141 142 143 144 145 146
             147 148 149 150 151 152 153 154 155 156 157 158
             159 160 161 162 163 190'

cr_block =  '164 165 166 167 168 169 170 171 172 173 174
             175 176 177 178 179 180 181 182 183 184 185
             186 187 188'

ref_cr_block = '${ref_block} ${cr_block}'

all_bloks = '   1   2   3   4   5   6   7   8   9  10
               11  12  13  14  15  16  17  18  19  20
               21  22  23  24  25  26  27  28  29  30
               31  32  33  34  35  36  37  38  39  40
               41  42  43  44  45  46  47  48  49  50
               51  52  53  54  55  56  57  58  59  60
               61  62  63  64  65  66  67  68  69  70
               71  72  73  74  75  76  77  78  79  80
               81  82  83  84  85  86  87  88  89  90
               91  92  93  94  95  96  97  98  99 100
              101 102 103 104 105 106 107 108 109 110
              111 112 113 114 115 116 117 118 119 120
              121 122 123 124 125 126 127 128 129 130
              131 132 133 134 135 136 137 138 139 140
              141 142 143 144 145 146 147 148 149 150
              151 152 153 154 155 156 157 158 159 160
              161 162 163 164 165 166 167 168 169 170
              171 172 173 174 175 176 177 178 179 180
              181 182 183 184 185 186 187 188 189 190'

material_ids =  '101 102 103 104 105 106 107 108 109 110
                 111 112 113 114 115 116 117 118 119 120
                 121 122 201 202 203 204 205 206 207 208
                 209 210 211 212 213 214 215 216 217 218
                 219 220 221 222 301 302 303 304 305 306
                 307 308 309 310 311 312 313 314 315 316
                 317 318 319 320 321 322 401 402 403 404
                 405 406 407 408 409 410 411 412 413 414
                 415 416 417 418 419 420 421 422 501 502
                 503 504 505 506 507 508 509 510 511 512
                 513 514 515 516 517 518 519 520 521 522
                   4   1   1   1   1   1   1   1   1   1
                   1   1   1   1   1   1   1   1   1   1
                   1   1   1   1   1   1   1   1   1   1
                   1   1   1   1   1   1   1   1   1   1
                   1   1   1   1   1   1   1   1   1   1
                   1   1   1   2   2   2   2   2   1   1
                   1   1   1   1   1   1   1   1   1   1
                   1   1   1   1   1   1   1   1   4   3'

# Reactor data -----------------------------------------------------------------
cr_ins_depth         = 11.0                   # Control Rods insertion depth 2m below the bottom of the top reflector (m).
reactor_total_power  = 400.0e+6               # Total Power (W).
dh_fract             = 6.426e-2               # Decay heat fraction at t = 0.0s.
fis_fract            = ${fparse 1 - dh_fract} # Fission power fraction at t = 0.0s.

# ==============================================================================
# GLOBAL PARAMETERS
# ==============================================================================
[GlobalParams]
  library_file = '../shared/oecd_pbmr400_tabulated_xs.xml'
  library_name = 'PBMR-400'
  scalar_fluxes = 'sflux_g0 sflux_g1'
  isotopes = 'pseudo'
  densities = '1.0'
  is_meter = true
[]

# ==============================================================================
# GEOMETRY AND MESH
# ==============================================================================
[Mesh]
  [cartesian_mesh]
    type = CartesianMeshGenerator
    dim = 2
    dx = '0.1000 0.3100 0.3260 0.0695 0.1150 0.0795 0.1700 0.1700 0.1700 0.1700 0.1700 0.0795 0.1150 0.0695 0.1360 0.1860 0.1700 0.1440 0.1250 0.0500'
    ix = '1 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1'

    dy = '0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000 0.5000'
    iy = '3 3 3 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 3 3 3'

    subdomain_id = '
                     132 132 132 132 163 124 115 115 115 115 115 143 188 151 151 154 154 154 189 190
                     132 132 132 132 163 124 115 115 115 115 115 143 188 151 151 154 154 154 189 190
                     132 132 132 132 163 124 114 114 114 114 114 143 188 151 151 154 154 154 189 190
                     134 134 134 131 162 123 22  44  66  88  110 142 187 151 151 153 153 153 189 190
                     134 134 134 131 162 123 21  43  65  87  109 142 186 151 151 153 153 153 189 190
                     134 134 134 130 161 122 20  42  64  86  108 141 185 150 150 153 153 153 189 190
                     134 134 134 130 161 122 19  41  63  85  107 141 184 150 150 153 153 153 189 190
                     134 134 134 130 161 122 18  40  62  84  106 141 183 150 150 153 153 153 189 190
                     134 134 134 129 160 121 17  39  61  83  105 140 182 149 149 153 153 153 189 190
                     134 134 134 129 160 121 16  38  60  82  104 140 181 149 149 153 153 153 189 190
                     134 134 134 129 160 121 15  37  59  81  103 140 180 149 149 153 153 153 189 190
                     134 134 134 129 160 121 14  36  58  80  102 140 179 149 149 153 153 153 189 190
                     134 134 134 128 159 120 13  35  57  79  101 139 178 148 148 153 153 153 189 190
                     134 134 134 128 159 120 12  34  56  78  100 139 177 148 148 153 153 153 189 190
                     134 134 134 128 159 120 11  33  55  77  99  139 176 148 148 153 153 153 189 190
                     134 134 134 128 159 120 10  32  54  76  98  139 175 148 148 153 153 153 189 190
                     134 134 134 127 158 119 9   31  53  75  97  138 174 147 147 153 153 153 189 190
                     134 134 134 127 158 119 8   30  52  74  96  138 173 147 147 153 153 153 189 190
                     134 134 134 127 158 119 7   29  51  73  95  138 172 147 147 153 153 153 189 190
                     134 134 134 127 158 119 6   28  50  72  94  138 171 147 147 153 153 153 189 190
                     134 134 134 126 157 118 5   27  49  71  93  137 170 146 146 153 153 153 189 190
                     134 134 134 126 157 118 4   26  48  70  92  137 169 146 146 153 153 153 189 190
                     134 134 134 126 157 118 3   25  47  69  91  137 168 146 146 153 153 153 189 190
                     134 134 134 125 156 117 2   24  46  68  90  136 167 145 145 153 153 153 189 190
                     134 134 134 125 156 117 1   23  45  67  89  136 166 145 145 153 153 153 189 190
                     133 133 133 133 155 116 111 111 111 111 111 135 165 144 144 152 152 152 189 190
                     133 133 133 133 155 116 112 112 112 112 112 135 164 144 144 152 152 152 189 190
                     133 133 133 133 155 116 113 113 113 113 113 135 164 144 144 152 152 152 189 190
                     133 133 133 133 155 116 113 113 113 113 113 135 164 144 144 152 152 152 189 190 '
  []
  [cartesian_mesh_ids]
    type = SubdomainElementIDs
    input = cartesian_mesh
    subdomains   = ${all_bloks}
    equivalence_ids = ${all_bloks}
    material_ids = ${material_ids}
  []
  uniform_refine = 0
[]

[Problem]
  coord_type = RZ
  rz_coord_axis = Y
[]

# ==============================================================================
# VARIABLES, AUXVARIABLES, INITIAL CONDITIONS AND FUNCTIONS
# ==============================================================================
[Variables]
  [NI]
    # family = LAGRANGE
    # order = FIRST
    block = ${fuel_block}
  []
  [NXe]
    # family = LAGRANGE
    # order = FIRST
    block = ${fuel_block}
  []
[]

[AuxVariables]
  [T_fuel]
    # family = MONOMIAL
    # order = CONSTANT
    block = ${fuel_block}
  []
  [T_kernel]
    # family = MONOMIAL
    # order = CONSTANT
    block = ${fuel_block}
  []
  [T_mod]
    # family = MONOMIAL
    # order = CONSTANT
    block = ${fuel_block}
  []
  [T_refl]
    # family = MONOMIAL
    # order = CONSTANT
    block = ${ref_cr_block}
  []
  [B1] # Fast buckling
    family = MONOMIAL
    order = CONSTANT
  []
  [B2] # Thermal buckling
    family = MONOMIAL
    order = CONSTANT
  []
  [FissionRR] # Fission rate density fissions/m^3/s
    family = L2_LAGRANGE
    order = FIRST
    block = ${fuel_block}
  []
  [scaled_sflux_g0] # Scaled fast flux n/m^2/s
    family = L2_LAGRANGE
    order = FIRST
  []
  [scaled_sflux_g1] # Scaled thermal flux n/m^2/s
    family = L2_LAGRANGE
    order = FIRST
  []
  [micro_xe_absorption_rate] # sum_g sigma_{Xe, g} * scalar_flux_g
    family = L2_LAGRANGE
    order = FIRST
  []
  [fission_power_density] # Energy fraction released Instantaneously from fission (W).
    family = MONOMIAL
    order = CONSTANT
  []
  [decay_heat_power_density] # Energy fraction released by fission products INITIAL (W).
    family = MONOMIAL
    order = CONSTANT
  []
  [transient_decay_heat_power_density] # Energy fraction released by fission products (W).
    family = MONOMIAL
    order = CONSTANT
  []
  [total_power_density] # Total Energy released from fission events (W).
    family = MONOMIAL
    order = CONSTANT
  []
[]

[Functions]
  [ssf]
    type = ConstantSourceFunction
    value = '0 0'
    NG = 2
  []
  # [decay_heat_scaling_function]
  #   type = PiecewiseLinear
  #   x = '0.0 365000.0'
  #   y = '1.0000e+00 1.0000e+00'
  # []
  [decay_heat_scaling_function]
    type = PiecewiseLinear
      x = '0.0      0.5      1.0      2.5      5.0
           10.0     20.0     50.0     100.0    200.0
           500.0    1000.0   2000.0   4000.0   6000.0
           10000.0  20000.0  40000.0  60000.0  100000.0
           150000.0 200000.0 250000.0 300000.0 365000.0'
      y = '1.0000e+00 9.6374e-01 9.3495e-01 8.7193e-01 8.0610e-01
           7.3203e-01 6.5608e-01 5.5898e-01 4.8817e-01 4.2624e-01
           3.5590e-01 3.0268e-01 2.4883e-01 1.9935e-01 1.7538e-01
           1.5033e-01 1.2372e-01 1.0193e-01 9.0570e-02 7.7653e-02
           6.8161e-02 6.2092e-02 5.7423e-02 5.3999e-02 5.0265e-02'
  []
  # [cr_position]
  #    type = ConstantFunction
  #    value = ${cr_ins_depth}
  # []
  [cr_position]
    # All control rods are fully inserted over 3 seconds to SCRAM the reactor
    type = PiecewiseLinear
    x = '0.0 13.0 16.0 180000.0'
    y = '${cr_ins_depth}
         ${cr_ins_depth}
         0.0
         0.0'
  []
  # [dts]
  #    type = PiecewiseConstant
  #    x = '0.0   180000.0'
  #    y = '0.0   60.0'
  #    direction = right
  # []
  # [dts]
  #    type = PiecewiseLinear
  #    x = '0.0   13.0  16.0  5000.0 60000.0 125000 180000.0'
  #    y = '1.0   0.1   0.1   120.0  1800.0  3600.0 3600.0'
  # []
  [dts]
     type = PiecewiseLinear
     x = '0.0   13.0  16.0  5000.0 60000.0 125000 180000.0'
     y = '1.0   0.1   0.1   120.0  1800.0  3600.0 3600.0'
  []
[]

# ==============================================================================
# KERNEL AND AUXKERNELS
# ==============================================================================
[Kernels]
  [Itd]
    type = TimeDerivative
    block = ${fuel_block}
    variable = NI
  []
  [IProduction] # from fission
    type = MatCoupledForce
    variable = NI
    v = FissionRR
    material_properties = iodine_yield
    coef = 1e-21
    block = ${fuel_block}
  []
  [IDestruction] # from Decay
    type = Collision
    block = ${fuel_block}
    variable = NI
    sigt = iodine_lambda
  []
  [Xetd]
    type = TimeDerivative
    block = ${fuel_block}
    variable = NXe
  []
  [XeProduction] # from I-135 decay and from fission
    type = MatCoupledForce
    variable = NXe
    v = 'FissionRR NI'
    material_properties = 'xenon_yield iodine_lambda'
    coef = '1e-21 1'
    block = ${fuel_block}
  []
  [XeDestruction] # from Decay and absorption
    type = Collision
    block = ${fuel_block}
    variable = NXe
    sigt = XeDestruction
  []
[]

[AuxKernels]
  [scaled_sflux_g0] #scaled flux unit is in n/m^2/s
    type = ScaleAux
    multiplying_pp = power_scaling
    variable = scaled_sflux_g0
    source_variable = sflux_g0
    execute_on = 'LINEAR TIMESTEP_END'
  []
  [scaled_sflux_g1] #scaled flux unit is in n/m^2/s
    type = ScaleAux
    multiplying_pp = power_scaling
    variable = scaled_sflux_g1
    source_variable = sflux_g1
    execute_on = 'LINEAR TIMESTEP_END'
  []
  [FissionRR]
    type = VectorReactionRate
    variable = FissionRR
    cross_section = sigma_fission
    scale_factor = power_scaling
    scalar_flux = 'sflux_g0 sflux_g1'
    block = ${fuel_block}
    execute_on = 'LINEAR TIMESTEP_END'
  []
  [micro_xe_absorption_rate_aux]
    type = VectorReactionRate
    variable = micro_xe_absorption_rate
    cross_section = XE135_Absorption
    scale_factor = 1.0e-28
    block = ${fuel_block}
    scalar_flux = 'scaled_sflux_g0 scaled_sflux_g1'
  []
  [fission_power_density]
    type = ScaleAux
    multiplying_pp = ${fis_fract}
    variable = fission_power_density
    source_variable = inst_power_density
  []
  [transient_decay_heat_power_density]
    type = ScaleAux
    multiplying_pp = decay_heat_scaling_factor
    variable = transient_decay_heat_power_density
    source_variable = decay_heat_power_density
    execute_on = 'INITIAL LINEAR TIMESTEP_END'
  []
  [total_power_density]
    type = ParsedAux
    function = 'fission_power_density + transient_decay_heat_power_density'
    args = 'fission_power_density transient_decay_heat_power_density'
    variable = total_power_density
    block = ${fuel_block}
    execute_on = 'INITIAL LINEAR TIMESTEP_END'
  []

  [buckling_aux_g0]
    type = BucklingAux
    variable = B1
    g = 0
    buckling_object = buckling_uo
    D = diffusion_coefficient_g0
    mesh_unit = meter
    buckling_unit = centimeter
    dummies = 'boundary_leakage_refl_g0 boundary_leakage_refl_g1
               boundary_leakage_vacuum_g0 boundary_leakage_vacuum_g1 block_leakage_g0
               block_leakage_g1 reaction_rate_g0 reaction_rate_g1'

  []
  [buckling_aux_g1]
    type = BucklingAux
    variable = B2
    g = 1
    buckling_object = buckling_uo
    D = diffusion_coefficient_g1
    mesh_unit = meter
    buckling_unit = centimeter
    dummies = 'boundary_leakage_refl_g0 boundary_leakage_refl_g1
               boundary_leakage_vacuum_g0 boundary_leakage_vacuum_g1 block_leakage_g0
               block_leakage_g1 reaction_rate_g0 reaction_rate_g1'
  []
[]

# ==============================================================================
# MATERIALS AND USER OBJECTS
# ==============================================================================
[PowerDensity]
  power = ${reactor_total_power}
  power_density_variable = inst_power_density
  integrated_power_postprocessor = Tt_pow
  family = MONOMIAL
  order = CONSTANT
[]

[Materials]
  [XeDestruction]  # (lambda_Xe + total_micro_Xeabs_RR )
    type = ParsedMaterial
    block = ${fuel_block}
    args = 'micro_xe_absorption_rate'
    material_property_names = 'xenon_lambda'
    f_name = XeDestruction
    function = 'xenon_lambda + micro_xe_absorption_rate'
  []
  [constant_props]
    type = GenericConstantMaterial
    prop_names = 'iodine_lambda   xenon_lambda  '
    prop_values = '2.93060718e-05 2.10657422e-05'
    block = ${fuel_block}
  []
  ## interpolate the yields using NEMTABReader
  [fission_yield_material]
    type = NEMTABMaterial
    nemtab_filename = '../shared/oecd_pbmr400_yields_xs.txt'
    region_id_type = material_id
    property_names = 'iodine_yield xenon_yield'
    grid_variables = 'T_fuel T_mod B1 B2 NXe'
    block = ${fuel_block}
  []
  [interpolate_xe_micro]
    type = MicroCrossSectionMaterial
    isotopes = 'XE135'
    reaction_types = Absorption
    grid_names = 'Tfuel Tmod B1 B2 Xe'
    grid_variables = 'T_fuel T_mod B1 B2 NXe'
    block = ${fuel_block}
  []
  [Fuel]
    type = CoupledFeedbackMatIDNeutronicsMaterial
    # note that in the XS tabulation Xe has already been added into pseudo
    grid_names = 'Tfuel Tmod B1 B2 Xe'
    grid_variables = 'T_fuel T_mod B1 B2 NXe'
    plus = true
    block = ${fuel_block}
  []
  [cavity_void]
    type = ConstantNeutronicsMaterial
    fromFile = false
    L = 2
    # enter a tensor
    #                  xx,   xy, xz, yx,  yy,    yz, zx, zy, zz
    diffusion_coef = '4.2789 0.  0.  0.  22.8055 0.  0.   0.  0.
                      4.2789 0.  0.  0.  22.8055 0.  0.   0.  0.'
    sigma_r = '0.0 0.0'
    sigma_s = '0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0'
    sigma_t = '0.07790164138 0.01461635716'
    neutron_speed = '1.33333333e+07 5.00000000e+05'
    material_id = 111
    block = '111'
  []
  [gap_void]
    type = ConstantNeutronicsMaterial
    fromFile = false
    L = 2
    # enter a tensor
    #                   xx,   xy, xz, yx,   yy,     yz, zx, zy, zz
    diffusion_coef = '0.268625 0.  0.  0.  8.280125 0.  0.   0.  0.
                      0.268625 0.  0.  0.  8.280125 0.  0.   0.  0.    '
    sigma_r = '0.0 0.0'
    sigma_s = '0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0'
    sigma_t = '1.24088723437 0.0402570412'
    neutron_speed = '1.33333333e+07 5.00000000e+05'
    material_id = 189
    block = '189'
  []
  [Reflectors]
    type = CoupledFeedbackMatIDNeutronicsMaterial
    grid_names = 'Tmod B1 B2'
    grid_variables = 'T_refl B1 B2'
    plus = true
    block = ${ref_block}
  []
  [CR]
    #type = MixedRoddedNeutronicsMaterial
    #grid = '3 2 2' # T_mod 800.0K B1 -0.0001 B2 5e-5
    type = CoupledFeedbackRoddedNeutronicsMaterial
    #grid_variables = '800 -0.0001 5e-5'
    grid_variables = 'T_refl B1 B2'
    isotopes = 'pseudo; pseudo; pseudo'
    densities = '1 1 1'
    block =  ${cr_block}
    grid_names = 'Tmod B1 B2'
    rod_withdrawn_direction = y
    segment_material_ids = '1 2 1'
    # front_position_function = ${cr_ins_depth}
    front_position_function = cr_position
    rod_segment_length = '100.0'
    plus = true
  []
[]

[UserObjects]
  # Restart variables from the steady solve
  # NOTE: The checkpoint system may alternatively be utilized to load variables
  [steady_poisons]
    type = SolutionVectorFile
    var = 'NXe NI micro_xe_absorption_rate'
    writing = false
    execute_on = 'INITIAL'
    folder = '../steady'
  []
  [steady_fluxes]
    type = SolutionVectorFile
    var = 'scaled_sflux_g0 scaled_sflux_g1 sflux_g0 sflux_g1'
    writing = false
    execute_on = 'INITIAL'
    folder = '../steady'
  []
  [steady_power]
    type = SolutionVectorFile
    var = 'inst_power_density fission_power_density decay_heat_power_density
           total_power_density FissionRR'
    writing = false
    execute_on = 'INITIAL'
    folder = '../steady'
  []
  [steady_temperatures]
    type = SolutionVectorFile
    var = 'T_fuel T_mod T_refl'
    writing = false
    execute_on = 'INITIAL'
    folder = '../steady'
  []
  [steady_buckling]
    type = SolutionVectorFile
    var = 'B1 B2'
    writing = false
    execute_on = 'INITIAL'
    folder = '../steady'
  []
  [steady_transport_sol]
    type = TransportSolutionVectorFile
    transport_system = diff
    writing = false
    execute_on = 'INITIAL'
    folder = '../steady'
  []

  ## buckling computation
  [buckling_uo]
    type = BucklingUserObject
    n_groups = 2
    boundary_leakages = 'boundary_leakage_refl_g0 boundary_leakage_refl_g1
                         boundary_leakage_vacuum_g0 boundary_leakage_vacuum_g1'
    block_leakages = 'block_leakage_g0 block_leakage_g1'
    reaction_rates = 'reaction_rate_g0 reaction_rate_g1'
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [block_leakage_g0]
    type = CDBlockBlockLeakage
    g = 0
    diffusion_coef = diffusion_coefficient_g0
    ingroup_phi = sflux_g0
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [block_leakage_g1]
    type = CDBlockBlockLeakage
    g = 1
    diffusion_coef = diffusion_coefficient_g1
    ingroup_phi = sflux_g1
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [boundary_leakage_refl_g0]
    type = CDBlockBoundaryLeakage
    boundary = 'left'
    bc_type = reflecting
    g = 0
    diffusion_coef = diffusion_coefficient_g0
    ingroup_phi = sflux_g0
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [boundary_leakage_refl_g1]
    type = CDBlockBoundaryLeakage
    boundary = 'left'
    bc_type = reflecting
    g = 1
    diffusion_coef = diffusion_coefficient_g1
    ingroup_phi = sflux_g1
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [boundary_leakage_vacuum_g0]
    type = CDBlockBoundaryLeakage
    boundary = 'bottom top right'
    bc_type = surface
    surface_source = ssf
    # for vacuum boundary conditions this factor is essential
    # for the balance table, vc = 2 is added unless a partial current mp
    # exists on the boundary
    vc = 2
    g = 0
    diffusion_coef = diffusion_coefficient_g0
    ingroup_phi = sflux_g0
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [boundary_leakage_vacuum_g1]
    type = CDBlockBoundaryLeakage
    boundary = 'bottom top right'
    bc_type = surface
    surface_source = ssf
    # for vacuum boundary conditions this factor is essential
    # for the balance table, vc = 2 is added unless a partial current mp
    # exists on the boundary
    vc = 2
    g = 1
    diffusion_coef = diffusion_coefficient_g1
    ingroup_phi = sflux_g1
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [reaction_rate_g0]
    type = TransportBlockReactionRates
    scalar_flux = sflux_g0
    g = 0
    sigt = sigma_total_g0
    scattering_xs = 'sigma_scattering_g0_g0 sigma_scattering_g0_g1'
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [reaction_rate_g1]
    type = TransportBlockReactionRates
    scalar_flux = sflux_g1
    g = 1
    sigt = sigma_total_g1
    scattering_xs = 'sigma_scattering_g1_g0 sigma_scattering_g1_g1'
    execute_on = 'INITIAL TIMESTEP_END'
  []
[]

# ==============================================================================
# EXECUTION PARAMETERS
# ==============================================================================
[TransportSystems]
  particle = neutron
  equation_type = transient

  G = 2

  VacuumBoundary = 'bottom top right'

  [diff]
    scheme = CFEM-Diffusion
    n_delay_groups = 6
    family = LAGRANGE
    order = FIRST
    fission_source_as_material = true
    assemble_scattering_jacobian = true
    assemble_fission_jacobian = true
    diffusion_kernel_type = tensor
    diffusion_coefficient_scheme = user_supplied
  []
[]

[Preconditioning]
  [SMP]
    type = SMP
    full = true
  []
[]

[Executioner]
  type = Transient

  scheme = implicit-euler

  # end_time = 6000.0
  end_time = 180000.0
  dt = 1e+15 # Let the master app control time steps.

  l_tol = 1e-4
  nl_rel_tol = 1e-7
  nl_abs_tol = 1e-8
  l_max_its = 75
  nl_max_its = 50

  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package -ksp_gmres_restart'
  petsc_options_value = 'lu superlu_dist 75'

  # Time step control.
  # [TimeStepper]
  #   type = FunctionDT
  #   function = dts
  # []

  [Quadrature]
    order = FOURTH
  []

[]

# ==============================================================================
# MULTIAPPS AND TRANSFER
# ==============================================================================
[MultiApps]
  [th_sub]
    type = TransientMultiApp
    app_type = FenixApp
    input_files = 'oecd_pbmr400_tr1_pplofc_phtn_flow_path.i'
    positions = '0.0 -2.8500 0.0' # Vertical offset between the two meshes.
    # sub_cycling = true
  []
[]

[Transfers]
  [power_density_to_th_sub]
    type = MultiAppInterpolationTransfer
    direction = to_multiapp
    multi_app = th_sub
    source_variable = total_power_density
    variable = power_density
  []
  [fuel_temperature_from_th_sub]
    type =  MultiAppInterpolationTransfer
    direction = from_multiapp
    multi_app = th_sub
    source_variable = T_fuel
    variable = T_fuel
  []
  [kernel_temperature_from_th_sub]
    type =  MultiAppInterpolationTransfer
    direction = from_multiapp
    multi_app = th_sub
    source_variable = T_kernel
    variable = T_kernel
  []
  [moderator_temperature_from_th_sub]
    type =  MultiAppInterpolationTransfer
    direction = from_multiapp
    multi_app = th_sub
    source_variable = T_mod
    variable = T_mod
  []
  [T_solid_to_reflector_temperature]
    type = MultiAppInterpolationTransfer
    direction = from_multiapp
    multi_app = th_sub
    source_variable = T_solid
    variable = T_refl
  []
[]

# ==============================================================================
# POSTPROCESSORS DEBUG AND OUTPUTS
# ==============================================================================
[Postprocessors]
  [decay_heat_scaling_factor]
    type = FunctionValuePostprocessor
    function = decay_heat_scaling_function
    execute_on = 'INITIAL TIMESTEP_BEGIN TIMESTEP_END FINAL'
  []
  [NI_avg]
    type = ElementAverageValue
    variable = NI
    block = ${fuel_block}
    execute_on = 'INITIAL TIMESTEP_END FINAL'
  []
  [NXe_avg]
    type = ElementAverageValue
    variable = NXe
    block = ${fuel_block}
    execute_on = 'INITIAL TIMESTEP_END FINAL'
  []
  [FRR_avg]
    type = ElementAverageValue
    block = ${fuel_block}
    variable = FissionRR
    execute_on = 'INITIAL TIMESTEP_END FINAL'
  []
  [flux0_avg]
    type = ElementAverageValue
    block = ${fuel_block}
    variable = scaled_sflux_g0
    execute_on = 'INITIAL TIMESTEP_END FINAL'
  []
  [flux1_avg]
    type = ElementAverageValue
    block = ${fuel_block}
    variable = scaled_sflux_g1
    execute_on = 'INITIAL TIMESTEP_END FINAL'
  []
  [T_fuel_avg]
    type = ElementAverageValue
    variable = T_fuel
    block = ${fuel_block}
    execute_on = 'INITIAL TIMESTEP_END FINAL'
  []
  [T_fuel_max]
    type = ElementExtremeValue
    variable = T_fuel
    block = ${fuel_block}
    value_type = max
    execute_on = 'INITIAL TIMESTEP_END FINAL'
  []
  [T_fuel_max_kernel]
    type = ElementExtremeValue
    variable = T_kernel
    block = ${fuel_block}
    value_type = max
    execute_on = 'INITIAL TIMESTEP_END FINAL'
  []
  [T_mod_avg]
    type = ElementAverageValue
    variable = T_mod
    block = ${fuel_block}
    execute_on = 'INITIAL TIMESTEP_END FINAL'
  []
  [time_step_pp]
    type = TimestepSize
    execute_on = 'INITIAL TIMESTEP_END FINAL'
  []
  [Fiss_power_tot]
    type = ElementIntegralVariablePostprocessor
    variable = fission_power_density
    block = ${fuel_block}
    execute_on = 'INITIAL TIMESTEP_END FINAL'
  []
  [Decay_heat_tot]
    type = ElementIntegralVariablePostprocessor
    variable = decay_heat_power_density
    block = ${fuel_block}
    execute_on = 'INITIAL TIMESTEP_END FINAL'
  []
  [Transient_decay_heat_tot]
    type = ElementIntegralVariablePostprocessor
    variable = transient_decay_heat_power_density
    block = ${fuel_block}
    execute_on = 'INITIAL TIMESTEP_END FINAL'
  []
  [reactor_total_power_check]
    type = ElementIntegralVariablePostprocessor
    variable = total_power_density
    block = ${fuel_block}
    execute_on = 'INITIAL TIMESTEP_END FINAL'
  []
[]

[Debug]
  show_actions = false
  show_material_props = false
  print_block_volume = false
  check_boundary_coverage = true
  show_neutronics_material_coverage = true
[]

[Outputs]
  file_base = oecd_pbmr400_tr0_pplofc_rsnk_keff_calc
  print_linear_residuals = false
  exodus = true
  csv = true
  perf_graph = false
[]
