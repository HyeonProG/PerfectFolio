package com.tenco.perfectfolio.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
    @RequestMapping("/")
    public String redirectToMain() {
        return "redirect:/user/main";
    }
}