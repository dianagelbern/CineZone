package com.salesianostriana.cinezone.error.exception.reservasexception;

public class AsientosOcupadosException extends RuntimeException{

    public AsientosOcupadosException(int numero, int fila){

        super(String.format("El asiento " + numero + " de la fila " + fila + " ya está ocupado por otra persona."));

    }

}
