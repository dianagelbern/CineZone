package com.salesianostriana.cinezone.error.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.http.HttpStatus;

import java.time.LocalDateTime;
import java.util.List;

import static com.fasterxml.jackson.annotation.JsonInclude.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ApiError {

    private HttpStatus estado;
    private int codigo;
    private String mensaje;
    private String ruta;

    @Builder.Default
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd/MM/yyyy HH:mm:ss")
    private LocalDateTime fecha = LocalDateTime.now();

    @JsonInclude(Include.NON_NULL)
    private List<ApiSubError> subErrores;


}
