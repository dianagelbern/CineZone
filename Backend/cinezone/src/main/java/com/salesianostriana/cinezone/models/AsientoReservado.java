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

    public void addToAsiento(Asiento a){
        asiento = a;
        a.getAsientosReservados().add(this);
    }

    public void removeFromAsiento(Asiento a){
        a.getAsientosReservados().remove(a);
        asiento = null;
    }

    public void addToReserva(Reserva r){
        reserva = r;
        r.getAsientosReservados().add(this);
    }

    public  void removeFromReserva(Reserva r){
        r.getAsientosReservados().remove(this);
        reserva = null;
    }

    public  void addReservaAsiento(Reserva r, Asiento a){
        addToAsiento(a);
        addToReserva(r);
    }

    public  void removeReservaAsiento(Reserva r, Asiento a){
        removeFromAsiento(a);
        removeFromReserva(r);
    }
}
