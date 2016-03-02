C_RED   = '\033[0;31m'
C_RESET   = '\033[0m'

common_mistakes = [
    'mas',
    'parametro',
    'particula',
    'asumiendo',
    'asumir',
    'energia',
    'numero',
    'analisis',
    'auto-estado',
    'capitulo',
    'seccion',
    'ano',
    'supercompanero',
    'pión',
    'ión',
    'muón',
    'ultimo',
    'sólo',
    'unico',
    'taza',
    'electrodebil',
    'ultima',
    'funcion',
    'electron',
    'categoria',
    'vertice',
    'simetria',
    'calculo',
    'senal',
    'linea',
    'limite',
    'supersimetria',
    'test',
    'tamano',
    'debil',
    'senal',
    'asume',
    'fermion',
    'lepton',
    'boson',
    'sleptón',
    'limite',
    'limites',
    # 'esta',
]

files = [
    'abstract.tex',
    'agradecimientos.tex',
    'commands.tex',
    'conclusion.tex',
    'detector.tex',
    'estadistica.tex',
    'estrategia.tex',
    'fondos.tex',
    'generacion_mc.tex',
    'introduccion.tex',
    'objetos.tex',
    'resultados.tex',
    'resumen.tex',
    'seleccion.tex',
    'simulaciones_sm.tex',
    'simulaciones_susy.tex',
    'simulaciones.tex',
    'sistematicos.tex',
    'sm.tex',
    'susy.tex',
    'teoria.tex',
    'thesis.tex',
    'title.tex',
]

for fname in files:

    print('- %s' % fname)

    with open(fname) as f:

        for line in f.readlines():

            line = line.strip()

            if line.startswith(r'%'):
                continue

            words = [ w.lower() for w in line.split() ]

            for error in common_mistakes:
                if error in words:
                    print(line.replace(error, C_RED+error+C_RESET))

            for w in words:
                if w.endswith('emos'):
                    print(line.replace(w, C_RED+w+C_RESET))
                    break

            if 'Sección' in words:
                print(line)
            if 'Capítulo' in words:
                print(line)
            if 'Tesis' in words:
                print(line)
