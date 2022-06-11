package com.salesianostriana.cinezone.services;

import com.salesianostriana.cinezone.error.exception.entitynotfound.SingleEntityNotFoundException;
import com.salesianostriana.cinezone.models.Asiento;
import com.salesianostriana.cinezone.models.Sala;
import com.salesianostriana.cinezone.repos.AsientoRepository;
import com.salesianostriana.cinezone.services.base.BaseService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AsientoService extends BaseService<Asiento, Long, AsientoRepository> {


    public List<Asiento> generateAsiento(int filas, int numero, Sala sala){
        List<Asiento> result = new ArrayList<>();

        for (int i = 1; i <= filas; i++){
            for (int j = 1; j <= numero; j++){
                Asiento newAsiento = Asiento.builder()
                        .fila(i)
                        .numero(j)
                        .sala(sala)
                        .build();
                result.add(newAsiento);
            }
        }
        return repositorio.saveAll(result);
    }

    public Asiento find(Long id){

        Optional<Asiento> optionalAsiento = repositorio.findById(id);

        if(optionalAsiento.isPresent()){
            return optionalAsiento.get();
        } else {
            throw new SingleEntityNotFoundException(Asiento.class);
        }

    }

}
