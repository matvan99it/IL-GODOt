shader_type canvas_item;

// Dichiarazione di una variabile uniforme per un input unico
uniform float seed;

// Funzione per generare un numero pseudo-casuale basato su un input
float random(float x) {
    return fract(sin(x) * 43758.5453);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
    // Usa il seme (seed) per generare un colore casuale
    float r = random(seed);
    float g = random(seed + 1.0); // leggera variazione per ottenere numeri diversi
    float b = random(seed + 2.0);

    // Colore finale: usa lo stesso colore per tutto l'elemento (tinta unita)
    vec4 color = vec4(r, g, b, 1.0);

    // Assegna il colore al frammento
    COLOR = color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
