package cc.altius.clinic;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@SpringBootApplication
public class ClinicApplication {

    public static void main(String[] args) {
        SpringApplication.run(ClinicApplication.class, args);
        System.out.println("password: " + new BCryptPasswordEncoder().encode("password"));
        System.out.println("doctor0: " + new BCryptPasswordEncoder().encode("doctor0"));
        System.out.println("doctor1: " + new BCryptPasswordEncoder().encode("doctor1"));
        System.out.println("doctor2: " + new BCryptPasswordEncoder().encode("doctor2"));
        System.out.println("receptionist: " + new BCryptPasswordEncoder().encode("receptionist"));
    }

}
