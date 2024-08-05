package com.example.project.ExceptionHandling;

public class PrimaryKeyCannotBeNullException extends Exception {

	public PrimaryKeyCannotBeNullException(String string) {
		super(string);
	}
}
