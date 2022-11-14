
Importante: Incluir las claves pública y privada del api de Marvel en el fichero Config/ProConfig.xconfig

Puntualizaciones sobre el proyecto, organización y componentes elegidos:

    - Gestión de dependencias: 
        Swift Package Manager.
        
    - Configuración de entornos: 
        Aunque en este proyecto tenemos un solo entorno que podríamos denominar "producción", he configurado los parámetros del mismo en Config/ProConfig.xconfig. 
        Aquí tendremos la base url de marvel y las claves pública/privada del API, las cuales adjunto vacías. Considero que queda fuera del propósito de esta prueba el incluir de forma segura dichas claves mediante ofuscación o encriptado.
        
    - Capa de acceso a red: 
        Al ser una entidad bancaria entiendo que se evitará en la media de lo posible usar librerías de terceros en partes críticas. En este caso no he usado librerías de terceros como Alamofire/Moya, optando por URLSession para la implementación de una pequeña capa con funciones básicas.
        
    - Tests: Se han implementado algunos test a modo de ejemplo, no se ha perseguido una covertura de código aceptable.
