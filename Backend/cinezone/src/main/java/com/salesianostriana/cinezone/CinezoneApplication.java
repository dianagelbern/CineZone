package com.salesianostriana.cinezone;

import com.salesianostriana.cinezone.config.StorageProperties;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@SpringBootApplication
@EnableConfigurationProperties(StorageProperties.class)
public class CinezoneApplication {

	public static void main(String[] args) {
		SpringApplication.run(CinezoneApplication.class, args);
	}

}
