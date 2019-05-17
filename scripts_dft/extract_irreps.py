import yaml

if __name__ == '__main__':

    stream = open("irreps.yaml", 'r')
    dictionary = yaml.safe_load(stream)
    freqs = []
    labels = []
    modes = dictionary['normal_modes']
    for mode in modes:
        if mode['frequency'] < 0:
            freqs.append(mode['frequency'])
            labels.append(mode['ir_label'])
    
    table_str = 'Frequency_(THz)\tIrrep_Symbol\n'
    for i in range(len(freqs)):
        table_str += f"{freqs[i]}\t{labels[i]}\n"
    print(table_str)