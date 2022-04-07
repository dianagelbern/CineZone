package com.salesianostriana.cinezone.error.exception.storage;

public class WrongFormatException extends RuntimeException{

    public WrongFormatException(String message, Exception e) {
        super(message, e);
    }

    public WrongFormatException(String message) {
        super(message);
    }
}
