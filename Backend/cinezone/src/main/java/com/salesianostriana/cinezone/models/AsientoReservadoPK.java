package com.salesianostriana.cinezone.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Embeddable;
import java.io.Serializable;

@Embeddable
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AsientoReservadoPK implements Serializable {

    private Long asiento_id;

    private Long reserva_id;
}
