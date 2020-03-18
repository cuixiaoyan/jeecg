package com.jeecg.cxy_conventional.service;
import com.jeecg.cxy_conventional.entity.CxyConventionalEntity;
import org.jeecgframework.core.common.service.CommonService;

import java.io.Serializable;

public interface CxyConventionalServiceI extends CommonService{
	
 	public void delete(CxyConventionalEntity entity) throws Exception;
 	
 	public Serializable save(CxyConventionalEntity entity) throws Exception;
 	
 	public void saveOrUpdate(CxyConventionalEntity entity) throws Exception;
 	
}
