package com.quiz.viewmodels;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

public class LoginViewModel {
	@Builder
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class LoginRequestViewModel {
		@Getter
		@Setter
		private String Email;
		@Getter
		@Setter
		private String Password;
	}
	
	@Builder
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class RegisterRequestViewModel {
		private String Name;
		private String Email;
		@Getter
		@Setter
		private String Password;
	}
	
	@Builder
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class LoginResponseViewModel{
		private String token;
		private String refreshToken;
		private LocalDateTime expiredDate;
	}
}
