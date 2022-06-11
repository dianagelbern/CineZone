package com.salesianostriana.cinezone.models;

import com.salesianostriana.cinezone.users.model.UserEntity;
import lombok.*;
import org.hibernate.annotations.NaturalId;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class Tarjeta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    //@NaturalId
    private String no_tarjeta;

    private LocalDate fecha_cad;

    private String titular;

    //Usuario asociado
    @ManyToOne
    private UserEntity usuario;

    @Builder.Default
    @OneToMany(mappedBy = "tarjeta", fetch = FetchType.EAGER)
    private List<Reserva> reservas = new ArrayList<>();
}
