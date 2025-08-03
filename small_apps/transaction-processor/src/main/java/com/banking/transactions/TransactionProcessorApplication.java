package com.banking.transactions;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.hystrix.EnableHystrix;

@SpringBootApplication
@EnableHystrix
public class TransactionProcessorApplication {
    
    public static void main(String[] args) {
        SpringApplication.run(TransactionProcessorApplication.class, args);
    }
}
