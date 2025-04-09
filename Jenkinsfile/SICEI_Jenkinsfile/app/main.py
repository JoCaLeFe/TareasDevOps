from fastapi import FastAPI

app = FastAPI(title="SICEI API", description="API para alumnos y profesores", version="1.0")

# Lista de alumnos (hardcoded)
alumnos = [
    {"nombre": "José Carlos Leo Fernández", "matricula": "21216389"},
    {"nombre": "Reyna Valentina Ortiz Porras", "matricula": "17003931"},
    {"nombre": "Carlos Augusto May Vivas", "matricula": "18001347"},
    {"nombre": "Fernando Joachín Prieto", "matricula": "18000621"},
    {"nombre": "Carlos Javier Calderón Delgado", "matricula": "21216389"},
    {"nombre": "Elías Madera De Regil", "matricula": "18000577"}
]

# Lista de profesores (hardcoded)
profesores = [
    {"nombre": "Mtro. Víctor Hugo Menéndez Domínguez", "numeroEmpleado": "UADY001"},
    {"nombre": "Mtro. Martín Leonel Chi Pérez", "numeroEmpleado": "UADY002"},
    {"nombre": "Mtro. Edwin Jesús León Bojórquez", "numeroEmpleado": "UADY003"},
    {"nombre": "Mtro. Luis Fernando Curi Quintal", "numeroEmpleado": "UADY004"},
    {"nombre": "Mtro. Luis Ramiro Basto Díaz", "numeroEmpleado": "UADY005"},
    {"nombre": "Mtro. Eduardo Antonio Rodríguez González", "numeroEmpleado": "UADY006"}
]

@app.get("/alumnos")
def obtener_alumnos():
    return alumnos

@app.get("/profesores")
def obtener_profesores():
    return profesores