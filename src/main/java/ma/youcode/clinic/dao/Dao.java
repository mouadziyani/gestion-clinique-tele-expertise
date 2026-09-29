package ma.youcode.clinic.dao;

import java.util.List;

public interface Dao<T>{
    
    void save(T t);

    T findById(int id);

    void delete(int id);

    List<T> findAll();

}
