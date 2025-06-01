package com.quiz.controllers.customer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.quiz.repository.StudentRepository;
import com.quiz.utils.JwtUtils;
import com.quiz.viewmodels.LoginViewModel.LoginRequestViewModel;
import com.quiz.viewmodels.LoginViewModel.LoginResponseViewModel;

@RestController
@RequestMapping("/app/v1/auth")
public class AuthController {
	@Autowired
    private AuthenticationManager authenticationManager;
	
	@Value("${jwt.expiration}")
    private Long jwtExpiration;
    
    @Autowired
    private UserDetailsService userDetailsService;
    
    @Autowired
    private JwtUtils jwtUtil;
    
    @Autowired
    private StudentRepository userRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
	
	@PostMapping("/login")
    public ResponseEntity<LoginResponseViewModel> login(@RequestBody LoginRequestViewModel request) {
        authenticationManager.authenticate(
            new UsernamePasswordAuthenticationToken(request.getEmail(), request.getPassword())
        );
        
        final UserDetails userDetails = userDetailsService.loadUserByUsername(request.getEmail());
        final String jwt = jwtUtil.generateToken(userDetails);
        final String refreshToken = jwtUtil.generateRefreshToken(userDetails);
        
        return ResponseEntity.ok(new LoginResponseViewModel(jwt, refreshToken , jwtUtil.calculateTokenExpiry()));
    }
    
//    @PostMapping("/register")
//    public ResponseEntity<LoginResponseViewModel> register(@RequestBody LoginRequestViewModel request) {
//        if (userRepository.findByEmail(request.getEmail()).isPresent()) {
//            return ResponseEntity.badRequest().build();
//        }
//        
////        User user = new User(
////            request.getName(),
////            request.getEmail(),
////            passwordEncoder.encode(request.getPassword()),
////            User.Role.STUDENT
////        );
////        
////        userRepository.save(user);
//        
////        final String jwt = jwtUtil.generateToken(user);
////        final String refreshToken = jwtUtil.generateRefreshToken(user);
//        
////        return ResponseEntity.ok(new AuthResponse(jwt, refreshToken));
//    }
    
    @PostMapping("/refresh")
    public ResponseEntity<LoginResponseViewModel> refresh(@RequestBody String refreshToken) {
        if (jwtUtil.isTokenValid(refreshToken)) {
            String username = jwtUtil.extractUsername(refreshToken);
            UserDetails userDetails = userDetailsService.loadUserByUsername(username);
            String newToken = jwtUtil.generateToken(userDetails);
            
            
            return ResponseEntity.ok(new LoginResponseViewModel(newToken, refreshToken, jwtUtil.calculateTokenExpiry()));
        }
        
        return ResponseEntity.badRequest().build();
    }
}
