package com.skilldistillery.quorum.entities;

import java.time.DayOfWeek;
import java.util.TreeSet;
import java.util.stream.Collectors;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class DayOfWeekConverter implements AttributeConverter<TreeSet<DayOfWeek>, String> {

	@Override
	public String convertToDatabaseColumn(TreeSet<DayOfWeek> attribute) {
		if (attribute != null) {
			return attribute.stream().map(Enum::name).collect(Collectors.joining("/"));
		} else {
			return null;
		}
	}

	@Override
	public TreeSet<DayOfWeek> convertToEntityAttribute(String dbData) {
		if (dbData != null) {
			TreeSet<DayOfWeek> daysOfWeek = new TreeSet<>();
			for (String day : dbData.split("/")) {
				daysOfWeek.add(DayOfWeek.valueOf(day));
			}
			return daysOfWeek;
		} else {
			return null;
		}
	}

}
