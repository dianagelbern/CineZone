package com.salesianostriana.cinezone.models;

import lombok.*;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@NamedEntityGraphs({
        @NamedEntityGraph(
                name = "grafo-sala-shows-cine",
                attributeNodes = {
                        @NamedAttributeNode("shows"),
                        @NamedAttributeNode("cine")
                }
        ),
        @NamedEntityGraph(
                name = "grafo-sala-show",
                attributeNodes = {
                        @NamedAttributeNode("shows")
                }
        ),
        @NamedEntityGraph(
                name = "grafo-sala-asientos",
                attributeNodes = {
                        @NamedAttributeNode("asientos")
                }
        ),
        @NamedEntityGraph(
                name = "grafo-sala-cine",
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
@EntityListeners(AuditingEntityListener.class)
public class Sala {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToMany(fetch = FetchType.LAZY)
    private List<Show> shows = new ArrayList<>();

    //Asientos (lista)
    @OneToMany
    private List<Asiento> asientos = new ArrayList<>();

    //Cine relacionado
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cine")
    private Cine cine;
}
