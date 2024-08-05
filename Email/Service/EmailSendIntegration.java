package com.example.project.Email.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.yaml.snakeyaml.scanner.ScannerImpl;

import jakarta.mail.MessagingException;

import java.io.File;

@Service
public class EmailSendIntegration {

    @Autowired
    private JavaMailSender mailSender;
    
    public void sendSimpleEmail(String toEmail, String body, String subject) {
    	SimpleMailMessage message = new SimpleMailMessage();
    	message.setFrom("jaichhajed799@gmail.com");
    	message.setTo(toEmail);
    	message.setText(body);
    	message.setSubject(subject);
    	mailSender.send(message);
    	System.out.println("mail sent...");
    }

    public void sendEmailWithAttachments(String toEmail, String body, String subject, String attachmentPath) throws MessagingException {
        jakarta.mail.internet.MimeMessage mimeMessage = mailSender.createMimeMessage();
        MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, true);

        FileSystemResource fileSystemResource = new FileSystemResource(new File(attachmentPath));

        mimeMessageHelper.setFrom("jaichhajed799@gmail.com");
        mimeMessageHelper.setTo(toEmail);
        mimeMessageHelper.setText(body);
        mimeMessageHelper.setSubject(subject);
        
        mimeMessageHelper.addAttachment(fileSystemResource.getFilename(), fileSystemResource);

        mailSender.send(mimeMessage);
        System.out.println("Mail Send...");
    }
}
