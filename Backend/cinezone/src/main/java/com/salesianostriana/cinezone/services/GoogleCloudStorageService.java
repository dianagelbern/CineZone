package com.salesianostriana.cinezone.services;

import com.google.auth.Credentials;
import com.google.auth.oauth2.GoogleCredentials;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.google.cloud.storage.*;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

@Service
public class GoogleCloudStorageService {


    @Value("${gcp.bucket.name}")
    private String bucketName;


    public String uploadFile(MultipartFile file) {
        Storage storage = StorageOptions.getDefaultInstance().getService();
        try {
            Credentials credentials = GoogleCredentials
                    .fromStream(new FileInputStream("../../Backend/cinezone/cine-zone-eb40926c10f6.json"));
            storage = StorageOptions.newBuilder().setCredentials(credentials)
                    .setProjectId("cine-zone").build().getService();
        } catch (IOException ex){
            ex.printStackTrace();
        }

        String filename = StringUtils.cleanPath(file.getOriginalFilename());

        try{
            byte[] img = file.getBytes();
            String newName = file.hashCode() + "_" + filename; //Al usar el hashcode nunca se repetirá el nombre

            //Creamos un id a partir del nombre del bucket y del nombre del fichero
            //BlobId id = BlobId.of(bucketName, newName);


            //BlobInfo es donde se crea el fichero (se gestiona todo para que se construya)
            BlobInfo info = storage.create(BlobInfo.newBuilder(bucketName, newName)
                    .setContentType(file.getContentType())
                    .build(), img);


            return info.getMediaLink();


        } catch (IOException ex){
            ex.printStackTrace();
        }

        return null;

    }

}
