package com.example.corona_request_maker;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Request {
    public String title, date, time, task, username, phone;
}
