package com.salesianostriana.cinezone.error;

import com.salesianostriana.cinezone.error.exception.ExistingUserException;
import com.salesianostriana.cinezone.error.exception.entitynotfound.SingleEntityNotFoundException;
import com.salesianostriana.cinezone.error.exception.reservasexception.AsientosOcupadosException;
import com.salesianostriana.cinezone.error.exception.reservasexception.RelacionInvalidaException;
import com.salesianostriana.cinezone.error.exception.reservasexception.ShowEnCursoException;
import com.salesianostriana.cinezone.error.exception.storage.WrongFormatException;
import com.salesianostriana.cinezone.error.model.ApiError;
import com.salesianostriana.cinezone.error.model.ApiSubError;
import com.salesianostriana.cinezone.error.model.ApiValidationSubError;
import org.hibernate.validator.internal.engine.path.PathImpl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import javax.persistence.EntityExistsException;
import javax.persistence.EntityNotFoundException;
import javax.validation.ConstraintViolationException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.ResourceBundle;
import java.util.stream.Collectors;

@RestControllerAdvice
public class GlobalRestControllerAdvice extends ResponseEntityExceptionHandler{

    @Override
    protected ResponseEntity<Object> handleExceptionInternal(Exception ex, Object body, HttpHeaders headers, HttpStatus status, WebRequest request) {
        return this.buildApiError(ex, status, request);
    }

    @Override
    protected ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException ex, HttpHeaders headers, HttpStatus status, WebRequest request) {


        List<ApiSubError> subErrorList = new ArrayList<>();

        ex.getAllErrors().forEach(error -> {

            if (error instanceof FieldError) {
                FieldError fieldError = (FieldError) error;

                subErrorList.add(
                        ApiValidationSubError.builder()
                                .objeto(fieldError.getObjectName())
                                .campo(fieldError.getField())
                                .valorRechazado(fieldError.getRejectedValue())
                                .mensaje(fieldError.getDefaultMessage())
                                .build()
                );
            }
            else
            {
                ObjectError objectError = (ObjectError) error;

                subErrorList.add(
                        ApiValidationSubError.builder()
                                .objeto(objectError.getObjectName())
                                .mensaje(objectError.getDefaultMessage())
                                .build()
                );
            }


        });



        return buildApiError(ex, HttpStatus.BAD_REQUEST, request,
                subErrorList.isEmpty() ? null : subErrorList

        );
    }

    @ExceptionHandler({ConstraintViolationException.class})
    public ResponseEntity<?> handleConstraintViolationException(ConstraintViolationException ex, WebRequest request) {

        return buildApiError(ex, HttpStatus.BAD_REQUEST, request, ex.getConstraintViolations()
                .stream()
                .map(cv -> ApiValidationSubError.builder()
                        .objeto(cv.getRootBeanClass().getSimpleName())
                        .campo(((PathImpl) cv.getPropertyPath()).getLeafNode().asString())
                        .valorRechazado(cv.getInvalidValue())
                        .mensaje(cv.getMessage())
                        .build()).collect(Collectors.toList()));
    }

    @ExceptionHandler({WrongFormatException.class})
    public ResponseEntity<?> handleWrongFormatException(WrongFormatException e, WebRequest request){

        return buildApiError(e, HttpStatus.BAD_REQUEST, request);

    }


    @ExceptionHandler({EntityNotFoundException.class})
    public ResponseEntity<?> handleNotFoundException(EntityNotFoundException e, WebRequest request) {

        return this.buildApiError(e, HttpStatus.NOT_FOUND, request);


    }

    @ExceptionHandler({SingleEntityNotFoundException.class})
    public ResponseEntity<?> handleSingleEntityNotFoundException(SingleEntityNotFoundException e, WebRequest request) {

        return this.buildApiError(e, HttpStatus.NOT_FOUND, request);


    }

    @ExceptionHandler({RelacionInvalidaException.class})
    public ResponseEntity<?> handleRelacionInvalidaException(RelacionInvalidaException e, WebRequest request) {

        return this.buildApiError(e, HttpStatus.resolve(409), request);


    }

    @ExceptionHandler({ShowEnCursoException.class})
    public ResponseEntity<?> ShowEnCursoException(RelacionInvalidaException e, WebRequest request) {

        return this.buildApiError(e, HttpStatus.resolve(409), request);


    }


    @ExceptionHandler({ExistingUserException.class})
    public ResponseEntity<?> handleExistingUserException(ExistingUserException e, WebRequest request) {

        return this.buildApiError(e, HttpStatus.BAD_REQUEST, request);


    }

    @ExceptionHandler({EntityExistsException.class})
    public ResponseEntity<?> handleRequestAlreadySentException(EntityExistsException e, WebRequest request){

        return buildApiError(e,"La petición aún está por confirmarse" ,HttpStatus.resolve(409), request);

    }


    @ExceptionHandler({AsientosOcupadosException.class})
    public ResponseEntity<?> handleAsientosOcupadosException (AsientosOcupadosException e, WebRequest request){

        return buildApiError(e,e.getMessage() ,HttpStatus.resolve(409), request);

    }

    private String getMessageForLocale(String messageKey, Locale locale){

        return ResourceBundle.getBundle("errors", locale).getString(messageKey);

    }


    private ResponseEntity<Object> buildApiError(Exception exception, HttpStatus status, WebRequest request, List<ApiSubError> subErrorList) {



        ApiError
                error = ApiError.builder()
                .estado(status)
                .codigo(status.value())
                .ruta(((ServletWebRequest) request).getRequest().getRequestURI())
                .mensaje("Hubo errores en la validación")
                .subErrores(subErrorList)
                .build();

        return ResponseEntity.status(status).body(error);
    }


    private ResponseEntity<Object> buildApiError(Exception exception, HttpStatus status, WebRequest request) {

        ApiError error = ApiError.builder()
                .estado(status)
                .codigo(status.value())
                .ruta(((ServletWebRequest) request).getRequest().getRequestURI())
                .mensaje(exception.getMessage())
                .build();

        return ResponseEntity.status(status).body(error);
    }

    private ResponseEntity<Object> buildApiError(Exception exception, String customMessage ,HttpStatus status, WebRequest request) {

        ApiError error = ApiError.builder()
                .estado(status)
                .codigo(status.value())
                .ruta(((ServletWebRequest) request).getRequest().getRequestURI())
                .mensaje(customMessage)
                .build();

        return ResponseEntity.status(status).body(error);
    }
}
