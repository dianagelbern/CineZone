package com.salesianostriana.cinezone.services;

import com.salesianostriana.cinezone.dto.tarjetadto.CreateTarjetaDto;
import com.salesianostriana.cinezone.error.exception.entitynotfound.EntityNotFoundException;
import com.salesianostriana.cinezone.error.exception.entitynotfound.ListEntityNotFoundException;
import com.salesianostriana.cinezone.error.exception.entitynotfound.SingleEntityNotFoundException;
import com.salesianostriana.cinezone.models.Reserva;
import com.salesianostriana.cinezone.models.Tarjeta;
import com.salesianostriana.cinezone.models.show.Show;
import com.salesianostriana.cinezone.repos.ReservaRepository;
import com.salesianostriana.cinezone.repos.TarjetaRepository;
import com.salesianostriana.cinezone.services.base.BaseService;
import com.salesianostriana.cinezone.users.model.UserEntity;
import com.salesianostriana.cinezone.users.service.UserEntityService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.swing.text.html.Option;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class TarjetaService extends BaseService<Tarjeta, Long, TarjetaRepository> {

    private final UserEntityService userEntityService;
    private final ReservaRepository reservaRepository;

    /**
     * Metodo que crea una nueva tarjeta asociandola a un usuario
     * @param tarjetaDto
     * @param currentUser
     * @return retorna la nueva tarjeta creada
     */
    public Tarjeta createTarjeta(CreateTarjetaDto tarjetaDto, UserEntity currentUser){


        Tarjeta newTarjeta = Tarjeta.builder()
                .usuario(currentUser)
                .titular(tarjetaDto.getTitular())
                .fecha_cad(tarjetaDto.getFecha_cad())
                .no_tarjeta(tarjetaDto.getNo_tarjeta())
                .build();

        repositorio.save(newTarjeta);
        userEntityService.save(currentUser);
        return newTarjeta;
    }

    /**
     * Trae todas las tarjetas asociadas a un usuario
     * @param pageable
     * @param user
     * @return Trae las tarjetas o una lista vacia
     */
    public Page<Tarjeta> findAllTarjetasByUser(Pageable pageable, UserEntity user){
        return repositorio.findAllTarjetasByUser(user.getId(), pageable);
    }

    /**
     * Elimina una tarjeta por su id
     * @param id
     * @return Si la tarjeta existe la elimina, de lo contrario trae una exception de tarjeta no encontrada
     */
    public Optional<?> deleteTarjetaById(Long id){
        Optional<Tarjeta> tarjeta = findById(id);



        if (tarjeta.isPresent()){

            UserEntity user = tarjeta.get().getUsuario();

            user.removeTarjeta(tarjeta.get());
            List<Reserva> reservas = reservaRepository.findAllReservasByTarjeta(tarjeta.get().getId());
            reservas.forEach(reserva -> reserva.setTarjeta(null));

            userEntityService.save(user);

            return deleteById(id);
        }else{
            throw new EntityNotFoundException("No se encontró ninguna tarjeta con ese id");
        }
    }

    /**
     * Trae una tarjeta por su id, este metodo nos ayudara para usarlo en otros servicios
     * @param id
     * @return retorna la tarjeta si existe, de lo contrario una exception de entidad no encontrada
     */
    public Tarjeta find(Long id) {
        Optional<Tarjeta> optionalTarjeta = findById(id);

        if (optionalTarjeta.isPresent()) {
            return optionalTarjeta.get();
        } else {
            throw new SingleEntityNotFoundException(Tarjeta.class);
        }

    }

    /**
     * Metodo que encuentra una tarjeta por medio de su numero, este nos servira para hacer
     * una comprobacion en otro servicio a futuro
     * @param num
     * @return la tarjeta
     */
    public Optional<Tarjeta> findByNum(String num){
        return repositorio.findTarjetaByNumber(num);
    }
}
