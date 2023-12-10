package com.skilldistillery.quorum.entities;

import java.time.DayOfWeek;
import java.util.HashSet;
import java.util.stream.Collectors;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class DayOfWeekConverter implements AttributeConverter<HashSet<DayOfWeek>, String> {

	@Override
	public String convertToDatabaseColumn(HashSet<DayOfWeek> attribute) {
		if (attribute != null) {
			return attribute.stream().map(Enum::name).collect(Collectors.joining("/"));
		} else {
			return null;
		}
	}

	@Override
	public HashSet<DayOfWeek> convertToEntityAttribute(String dbData) {
		if (dbData != null) {
			HashSet<DayOfWeek> daysOfWeek = new HashSet<>();
			for (String day : dbData.split("/")) {
				daysOfWeek.add(DayOfWeek.valueOf(day));
			}
			return daysOfWeek;
		} else {
			return null;
		}
	}

}
