#loc='qaddr:/projects/b1027/KDMiller_work/BaCoS2/correct_mag/phonons'
loc='qaddr:/projects/p30883/trirutiles/MgTa2O6/carrier_doping/phonons'

rsync -avz --prune-empty-dirs --include='*/' --include="/*/FORCE_SETS" --include="/*/POSCAR" --include="/*/*.yaml" --include="/*/BORN" --include="/*/SPOSCAR" --exclude="*" --exclude="*/" $loc/ .
