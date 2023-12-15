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
   private int postNo;
   private String author;
   private Timestamp createdDate;
   private String title;
   private String content;
   private int categoryId;
   private int ref;
   private int step;
   private int refOrder;
   private int likes;
   private int parentPost;
}