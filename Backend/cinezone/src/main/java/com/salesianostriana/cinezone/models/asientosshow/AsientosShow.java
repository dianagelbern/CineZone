package com.salesianostriana.cinezone.models.asientosshow;

import com.salesianostriana.cinezone.models.Asiento;
import com.salesianostriana.cinezone.models.Reserva;
import com.salesianostriana.cinezone.models.show.Show;
import lombok.*;

import javax.persistence.*;


@Entity
@NoArgsConstructor @AllArgsConstructor
@Getter
@Setter
@Builder
public class AsientosShow {

    @Builder.Default
    @EmbeddedId
    private AsientosShowPK id = new AsientosShowPK();

    @ManyToOne
    @MapsId("asiento_id")
    @JoinColumn(name="asiento_id")
    private Asiento asiento;

    @ManyToOne
    @MapsId("show_id")
    @JoinColumn(name="show_id")
    private Show show;

    //@ManyToOne(fetch = FetchType.LAZY)
    @OneToOne
    private Reserva reserva;

    private boolean esOcupado;


    //HELPERS


    public void addToAsiento(Asiento a) {
        asiento = a;
        a.getAsientosShows().add(this);
    }

    public void removeFromAsiento(Asiento a) {
        asiento = null;
        a.getAsientosShows().remove(this);

    }

    public void addToShow(Show s) {
        show = s;
        s.getAsientosShow().add(this);
    }

    public void removeFromShow(Show s ) {
        s.getAsientosShow().remove(this);
        show = null;
    }

}
