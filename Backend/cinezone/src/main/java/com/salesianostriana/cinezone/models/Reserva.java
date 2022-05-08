package com.salesianostriana.cinezone.models;

import com.salesianostriana.cinezone.models.asientosshow.AsientosShow;
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

   /* @OneToMany(mappedBy = "reserva")
    private List<AsientosShow> asientosReservados = new ArrayList<>();*/

    @OneToOne
    private AsientosShow asientoReservado;

    //Cine
    @ManyToOne
    @JoinColumn(name = "cine_id")
    private  Cine cine;

}
