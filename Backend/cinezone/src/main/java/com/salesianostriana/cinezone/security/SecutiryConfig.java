package com.salesianostriana.cinezone.security;


import com.salesianostriana.cinezone.security.jwt.JwtAccesDeniedHandler;
import com.salesianostriana.cinezone.security.jwt.JwtAuthorizationFilter;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.header.writers.StaticHeadersWriter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
@Configuration
@RequiredArgsConstructor
public class SecutiryConfig extends WebSecurityConfigurerAdapter {

    private final UserDetailsService userDetailsService;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationEntryPoint authenticationEntryPoint;
    private final JwtAuthorizationFilter filter;
    private final JwtAccesDeniedHandler accessDeniedHandler;

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder);
    }

    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }


    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .csrf().disable()
                .exceptionHandling()
                .authenticationEntryPoint(authenticationEntryPoint)
                .accessDeniedHandler(accessDeniedHandler)
                .and()
                .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                .authorizeRequests()
                .antMatchers(HttpMethod.POST, "/auth/login").permitAll()
                .antMatchers(HttpMethod.POST, "/auth/register/usuario").permitAll()
                .antMatchers(HttpMethod.POST, "/auth/register/admin").permitAll()
                .antMatchers(HttpMethod.GET, "/usuarios").authenticated()
                .antMatchers(HttpMethod.GET, "/usuario/**").hasAnyRole("USER", "ADMIN")
                .antMatchers(HttpMethod.DELETE, "/usuario/**").hasAnyRole("USER", "ADMIN")
                .antMatchers(HttpMethod.GET, "/user/me").authenticated()
                .antMatchers("/h2-console/**").permitAll()
                .anyRequest().authenticated()
                .and().httpBasic()
                .and().headers().frameOptions().disable()
                .and().csrf().disable()
                .headers()
                .addHeaderWriter(new StaticHeadersWriter("Access-Control-Allow-Origin", "*"))
                .addHeaderWriter(new StaticHeadersWriter("Access-Control-Allow-Methods", "POST, GET"))
                .addHeaderWriter(new StaticHeadersWriter("Access-Control-Max-Age", "3600"))
                .addHeaderWriter(new StaticHeadersWriter("Access-Control-Allow-Credentials", "true"))
                .addHeaderWriter(new StaticHeadersWriter("Access-Control-Allow-Headers", "Origin,Accept,X-Requested-With,Content-Type,Access-Control-Request-Method,Access-Control-Request-Headers,Authorization"));

        http.cors().configurationSource(corsConfigurationSource());
        http.addFilterBefore(filter, UsernamePasswordAuthenticationFilter.class);

        http.headers().frameOptions().disable();


    }

    CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        List<String> allowOrigins = Arrays.asList("*");
        configuration.setAllowedOrigins(allowOrigins);
        configuration.setAllowedOrigins(List.of("http://localhost:4200"));
        //in case authentication is enabled this flag MUST be set, otherwise CORS requests will fail
        configuration.setAllowCredentials(true);
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
}
