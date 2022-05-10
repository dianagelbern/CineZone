package com.salesianostriana.cinezone.users.model;

import com.salesianostriana.cinezone.models.Asiento;
import com.salesianostriana.cinezone.models.Reserva;
import com.salesianostriana.cinezone.models.Tarjeta;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.NaturalId;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.UUID;


@Entity
@Table(name="users")
@EntityListeners(AuditingEntityListener.class)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserEntity implements UserDetails, Serializable {

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

    private String nombre, telefono, password, fechaNacimiento;

    @NaturalId
    @Column(unique = true, updatable = false)
    private String email;

    @Enumerated(EnumType.STRING)
    private UserRole role;


    @Builder.Default
    @OneToMany(fetch = FetchType.EAGER)
    private List<Reserva> reservas = new ArrayList<>();



    @Builder.Default
    @OneToMany
    private List<Tarjeta> tarjetas = new ArrayList<>();

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority("ROLE_" +role.name()));
    }

    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }


    //HELPERS

    public void addReserva(Reserva reserva){
        this.getReservas().add(reserva);
        reserva.setUser(this);
    }

    public void removeReserva(Reserva reserva){
        this.getReservas().remove(reserva);
        reserva.setUser(null);
    }


}
