import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AuthLoginDto } from 'src/app/interfaces/dto/auth.dto';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-log-in',
  templateUrl: './log-in.component.html',
  styleUrls: ['./log-in.component.css']
})
export class LogInComponent implements OnInit {
  loginDto = new AuthLoginDto();
  public showPassword: boolean = false;

  constructor(private authService: AuthService, private router: Router) { }

  ngOnInit(): void {
  }

  public togglePasswordVisibility(): void {
    this.showPassword = !this.showPassword;
  }


  doLogin() {
    this.authService.login(this.loginDto).subscribe(loginResult => {
      this.router.navigate(['/home'])
    });
  }
}
