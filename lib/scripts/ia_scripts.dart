class IaScripts {
  static final analisisDatos = """
    Quiero que analices la imagen q te voy a mandar y solo enfocate en lo principal,
    e ignora lo q esta alrededor y dime que es el objeto y quiero que me respondas de esta forma ojo no quiero que agregues mas cosas nuevas 
    ""{
      "nombreObjeto":"{el nombre del objeto como tal}",
      "pronunciacion":"{el texto del objeto pero como pronunciacion}",
      "colors:[
      {ten en cuenta que aqui deb haber como un tipo de lista de colores que tiene ese objeto}
      "color 1"
      ],
      "audio":"{nombre del objeto}",
      "ejemploPasado":"{Ejemplo de la palabra en una oracion como ejemplo pero en pasado}",
      "ejemploPresente":"{Ejemplo de la palabra en una oracion como ejemplo pero en presente}",
      "ejemploFuturo":"{Ejemplo de la palabra en una oracion como ejemplo pero en futuro}"
    }""
    no me respondas con ´´´json nunca analiza lo de arriba toma en cuenta el scrip de acuerdo a lo que te digo
    datos extra: 
    - debe tener en cuenta el objeto que esta al frente ignorando los que estan al alrededor
    - ten en cuenta correctamente la pronunciacion
    - tener en cuenta si es una persona que esta al frente decir que parte del cuerpo es
    - si no detecta ningun objeto ni nada solo devolver "" osea nulo
    - dame la respuesta en español

  """;
}