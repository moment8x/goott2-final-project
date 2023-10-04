package com.project.vodto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Board {
   private int post_no;
   private String author;
   private Timestamp created_date;
   private String title;
   private String content;
   private int file;
   private int ref;
   private int step;
   private int ref_order;
   private int likes;
}