package com.salesianostriana.cinezone.models;

import lombok.*;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter
@Builder
@EntityListeners(AuditingEntityListener.class)
public class AsientoReservado implements Serializable {


    @EmbeddedId
    @Builder.Default
    private AsientoReservadoPK id = new AsientoReservadoPK();

    @ManyToOne
    @MapsId("asiento_id")
    @JoinColumn(name = "asiento_id")
    private Asiento asiento;

    @ManyToOne
    @MapsId("reserva_id")
    @JoinColumn(name = "reserva_id")
    private Reserva reserva;
}
