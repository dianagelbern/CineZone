package com.salesianostriana.cinezone.models;

import com.salesianostriana.cinezone.models.asientosshow.AsientosShow;
import com.salesianostriana.cinezone.users.model.UserEntity;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;


@NamedEntityGraphs({
        @NamedEntityGraph(
                name = "grafo-reserva-user-asientoReservado-cine",
                attributeNodes = {
                        @NamedAttributeNode("user"),
                        @NamedAttributeNode("asientoReservado"),
                        @NamedAttributeNode("cine")
                }
        ),
        @NamedEntityGraph(
                name = "grafo-reserva-user",
                attributeNodes = {
                        @NamedAttributeNode("user")
                }
        ),
        @NamedEntityGraph(
                name = "grafo-reserva-asientoReservado",
                attributeNodes = {
                        @NamedAttributeNode("asientoReservado")
                }
        ),
        @NamedEntityGraph(
                name = "grafo-reserva-cine",
                attributeNodes = {
                        @NamedAttributeNode("cine")
                }
        )
})
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class Reserva {

    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(
            name = "UUID",
            strategy = "org.hibernate.id.UUIDGenerator",
            parameters = {
                    @org.hibernate.annotations.Parameter(
                            name = "uuid_gen_strategy_class",
                            value = "org.hibernate.id.uuid.CustomVersionOneStrategy"
                    )
            }
    )
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @Builder.Default
    @CreatedDate
    private LocalDateTime fecha = LocalDateTime.now();

    //Usuario asociado
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private UserEntity user;

    //Asociar con asiento por medio de la nueva clase

   /* @OneToMany(mappedBy = "reserva")
    private List<AsientosShow> asientosReservados = new ArrayList<>();*/

    @OneToOne(fetch = FetchType.LAZY)
    private AsientosShow asientoReservado;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "tarjeta_id")
    private Tarjeta tarjeta;

    //Cine
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cine_id")
    private  Cine cine;

}
