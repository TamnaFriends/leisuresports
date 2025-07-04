// domain/User.java
package com.tamna.leisure.domain;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "users")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class User {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long userId;

    @Column(nullable = false, unique = true, length = 100)
    private String email;

    @Column(nullable = false, unique = true, length = 20)
    private String phone;

    @Column(nullable = false, length = 255)
    private String passwordHash;

    @Column(nullable = false, unique = true, length = 40)
    private String nickname;

    @Column(length = 8)
    private String birthday;

    @Column(length = 1)
    private String gender;

    @Column(columnDefinition = "json")
    private String agreementsJson;

    @Column(nullable = false)
    private Boolean mfaEnabled = false;

    @Column(length = 255)
    private String mfaSecret;

    @Column(length = 20)
    private String status = "active";

    @Column
    private java.sql.Timestamp createdAt;

    @Column
    private java.sql.Timestamp updatedAt;

    @Column
    private java.sql.Timestamp deletedAt;

    @Column(length = 512)
    private String recoveryCodes;
}
