package com.salesianostriana.cinezone.models.asientosshow;

import lombok.*;

import javax.persistence.Embeddable;
import java.io.Serializable;

@Embeddable
@Getter
@Setter
@NoArgsConstructor @AllArgsConstructor
public class AsientosShowPK implements Serializable {

    private Long asiento_id;

    private Long show_id;

}
