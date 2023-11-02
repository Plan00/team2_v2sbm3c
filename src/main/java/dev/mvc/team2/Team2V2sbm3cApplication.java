package dev.mvc.team2;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"dev.mvc"})
public class Team2V2sbm3cApplication {

	public static void main(String[] args) {
		SpringApplication.run(Team2V2sbm3cApplication.class, args);
	}

}
