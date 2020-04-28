package com.jeecg.authorizedmenu.service;
import com.jeecg.authorizedmenu.entity.AuthorizedmenuEntity;
import org.jeecgframework.core.common.service.CommonService;

import java.io.Serializable;

public interface AuthorizedmenuServiceI extends CommonService{
	
 	public void delete(AuthorizedmenuEntity entity) throws Exception;
 	
 	public Serializable save(AuthorizedmenuEntity entity) throws Exception;
 	
 	public void saveOrUpdate(AuthorizedmenuEntity entity) throws Exception;
 	
}
