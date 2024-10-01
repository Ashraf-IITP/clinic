/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cc.altius.clinic;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

/**
 *
 * @author altius
 */
@Configuration
@EnableWebSecurity
public class SpringBootSecurity {

    @Autowired
    private UserDetailsService userService;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .formLogin(form
                        -> form
                        .loginPage("/login.htm")
                        .defaultSuccessUrl("/index.htm")
                        .permitAll()
                )
                .logout(out
                        -> out
                        .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
                        .logoutSuccessUrl("/login.htm")
                        .permitAll()
                )
                .authenticationProvider(this.authenticationProvider())
                .authorizeHttpRequests(t -> t
                .requestMatchers(
                        "/",
                        "/error/**",
                        "/js/**",
                        "/images/**",
                        "/css/**",
                        "/favicon.ico",
                        "/WEB-INF/jsp/**"
                ).permitAll()
                .requestMatchers("/index.htm**").hasAnyAuthority("ROLE_BF_SHOW_HOME")
                .requestMatchers(
                        "/addUser.htm**",
                        "/editUser.htm**",
                        "/showEditUser.htm**",
                        "/listUser.htm**"
                ).hasAnyAuthority("ROLE_BF_MANAGE_USER")
                .requestMatchers(
                        "/addPatient.htm**",
                        "/editPatient.htm**",
                        "/showEditPatient.htm**",
                        "/listPatient.htm**",
                        "/searchPatient.htm**"
                ).hasAnyAuthority("ROLE_BF_MANAGE_PATIENT")
                .requestMatchers(
                        "/ajaxGetDoctorSchedules.htm**",
                        "/addDoctorSchedule.htm**"
                ).hasAnyAuthority("ROLE_BF_DR_SCHEDULE")
                .requestMatchers(
                        "/addAppointment.htm**",
                        "/ajaxGetDrAvailableSlots.htm**",
                        "/viewDoctorCalendar.htm**",
                        "/showEditAppointment.htm**",
                        "/editAppointment.htm**",
                        "/addAppointmentFromCalendar.htm**",
                        "/ajaxGetDoctorCalendar.htm**"
                ).hasAnyAuthority("ROLE_BF_MANAGE_APPT")
                .anyRequest().authenticated()
                );
        return http.build();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(this.userService);
        authProvider.setPasswordEncoder(this.bcryptPasswordEncoder());
        return authProvider;
    }

    @Bean
    public PasswordEncoder bcryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

}
