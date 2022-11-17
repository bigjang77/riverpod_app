package com.example.fserver;

import java.util.List;

import javax.persistence.EntityManager;

import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class ProductRespository2 {

    private final EntityManager em;

    public List<Product> findAll() {
        return em.createQuery("select p from Product p", Product.class).getResultList();
    }
}
