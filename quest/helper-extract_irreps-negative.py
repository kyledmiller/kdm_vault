import yaml
import sys

if __name__ == '__main__':

    stream = open("irreps.yaml", 'r')
    dictionary = yaml.safe_load(stream)
    freqs = []
    labels = []
    modes = dictionary['normal_modes']
    for mode in modes:
        if mode['frequency'] < 0:
            freqs.append(mode['frequency'])
        try:
            labels.append(mode['ir_label'])
        except:
            labels.append('unk')
 
    kpt = sys.argv[1]
    #table_str = 'Frequency_(THz)\tIrrep_Symbol\n'
    table_str = ''
    for i in range(len(freqs)):
        table_str += f"{kpt}\t{freqs[i]}\t{labels[i]}\n"
    print(table_str)
