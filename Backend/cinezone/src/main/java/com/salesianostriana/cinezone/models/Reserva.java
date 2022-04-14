package com.salesianostriana.cinezone.models;

import com.salesianostriana.cinezone.users.model.UserEntity;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class Reserva {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @CreatedDate
    private LocalDateTime fecha;

    //Usuario asociado
    @ManyToOne
    private UserEntity user;

    //Asociar con asiento por medio de la nueva clase

    @OneToMany
    private List<AsientoReservado> asientos = new ArrayList<>();
}
