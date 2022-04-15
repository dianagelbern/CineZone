package com.salesianostriana.cinezone.error.exception;

public class ExistingUserException extends RuntimeException{

    public ExistingUserException(){

        super(String.format("El usuario ya existe"));

    }
}
