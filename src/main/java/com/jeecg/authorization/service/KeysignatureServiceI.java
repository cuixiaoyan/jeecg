package com.jeecg.authorization.service;
import com.jeecg.authorization.entity.KeysignatureEntity;
import org.jeecgframework.core.common.service.CommonService;

import java.io.Serializable;

public interface KeysignatureServiceI extends CommonService{
	
 	public void delete(KeysignatureEntity entity) throws Exception;
 	
 	public Serializable save(KeysignatureEntity entity) throws Exception;
 	
 	public void saveOrUpdate(KeysignatureEntity entity) throws Exception;
 	
}
