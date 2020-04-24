package com.jeecg.authorization.controller;

import com.jeecg.authorization.entity.KeysignatureEntity;
import com.jeecg.authorization.service.KeysignatureServiceI;

import java.security.KeyPair;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;

import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.core.util.MyBeanUtils;

import org.jeecgframework.poi.excel.ExcelImportUtil;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.jeecgframework.poi.excel.entity.vo.NormalExcelConstants;
import org.jeecgframework.core.util.ResourceUtil;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.jeecgframework.core.util.ExceptionUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author onlineGenerator
 * @version V1.0
 * @Title: Controller
 * @Description: 密钥签名授权
 * @date 2020-04-23 17:28:41
 */
@Controller
@RequestMapping("/keysignatureController")
public class KeysignatureController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(KeysignatureController.class);

    @Autowired
    private KeysignatureServiceI keysignatureService;
    @Autowired
    private SystemService systemService;
    @Autowired
    private RSAUtilPbulicKey rSAUtilPbulicKey;


    /**
     * 密钥签名授权列表 页面跳转
     *
     * @return
     */
    @RequestMapping(params = "list")
    public ModelAndView list(HttpServletRequest request) {
        return new ModelAndView("com/jeecg/authorization/keysignatureList");
    }

    /**
     * easyui AJAX请求数据
     *
     * @param request
     * @param response
     * @param dataGrid
     * @param user
     */
    @RequestMapping(params = "datagrid")
    public void datagrid(KeysignatureEntity keysignature, HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
        CriteriaQuery cq = new CriteriaQuery(KeysignatureEntity.class, dataGrid);
        //查询条件组装器
        org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, keysignature, request.getParameterMap());
        cq.add();
        this.keysignatureService.getDataGridReturn(cq, true);
        TagUtil.datagrid(response, dataGrid);
    }

    /**
     * 删除密钥签名授权
     *
     * @return
     */
    @RequestMapping(params = "doDel")
    @ResponseBody
    public AjaxJson doDel(KeysignatureEntity keysignature, HttpServletRequest request) {
        String message = null;
        AjaxJson j = new AjaxJson();
        keysignature = systemService.getEntity(KeysignatureEntity.class, keysignature.getId());
        message = "密钥签名授权删除成功";
        try {
            keysignatureService.delete(keysignature);
            systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
        } catch (Exception e) {
            e.printStackTrace();
            message = "密钥签名授权删除失败";
            throw new BusinessException(e.getMessage());
        }
        j.setMsg(message);
        return j;
    }

    /**
     * 批量删除密钥签名授权
     *
     * @return
     */
    @RequestMapping(params = "doBatchDel")
    @ResponseBody
    public AjaxJson doBatchDel(String ids, HttpServletRequest request) {
        String message = null;
        AjaxJson j = new AjaxJson();
        message = "密钥签名授权删除成功";
        try {
            for (String id : ids.split(",")) {
                KeysignatureEntity keysignature = systemService.getEntity(KeysignatureEntity.class,
                        id
                );
                keysignatureService.delete(keysignature);
                systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "密钥签名授权删除失败";
            throw new BusinessException(e.getMessage());
        }
        j.setMsg(message);
        return j;
    }


    /**
     * 添加密钥签名授权
     *
     * @param ids
     * @return
     */
    @RequestMapping(params = "doAdd")
    @ResponseBody
    public AjaxJson doAdd(KeysignatureEntity keysignature, HttpServletRequest request) {
        String message = null;
        AjaxJson j = new AjaxJson();
        message = "密钥签名授权添加成功";
        try {
            //拼接明文
            String clear = keysignature.getUserName() + keysignature.getByTime() + keysignature.getAuthorizationModule();
            //生成公钥，私钥。
            Map<String, String> keyPairs = rSAUtilPbulicKey.getKeyPairs();
            //私钥加密，生成密文。
            String encryptData = rSAUtilPbulicKey.encryptByPrivateKey(clear);
            //计算生成
            keysignature.setPublicKey(keyPairs.get("publicKeyStr"));
            keysignature.setPrivateKey(keyPairs.get("privateKeyStr"));
            keysignature.setClear(clear);
            keysignature.setCipher(encryptData);

            keysignatureService.save(keysignature);
            systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
        } catch (Exception e) {
            e.printStackTrace();
            message = "密钥签名授权添加失败";
            throw new BusinessException(e.getMessage());
        }
        j.setMsg(message);
        return j;
    }

    /**
     * 更新密钥签名授权
     *
     * @param ids
     * @return
     */
    @RequestMapping(params = "doUpdate")
    @ResponseBody
    public AjaxJson doUpdate(KeysignatureEntity keysignature, HttpServletRequest request) {
        String message = null;
        AjaxJson j = new AjaxJson();
        message = "密钥签名授权更新成功";
        KeysignatureEntity t = keysignatureService.get(KeysignatureEntity.class, keysignature.getId());
        try {
            //拼接明文
            String clear = keysignature.getUserName() + keysignature.getByTime() + keysignature.getAuthorizationModule();
            //生成公钥，私钥。
            Map<String, String> keyPairs = rSAUtilPbulicKey.getKeyPairs();
            //私钥加密，生成密文。
            String encryptData = rSAUtilPbulicKey.encryptByPrivateKey(clear);
            //计算生成
            keysignature.setPublicKey(keyPairs.get("publicKeyStr"));
            keysignature.setPrivateKey(keyPairs.get("privateKeyStr"));
            keysignature.setClear(clear);
            keysignature.setCipher(encryptData);

            MyBeanUtils.copyBeanNotNull2Bean(keysignature, t);
            keysignatureService.saveOrUpdate(t);
            systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
        } catch (Exception e) {
            e.printStackTrace();
            message = "密钥签名授权更新失败";
            throw new BusinessException(e.getMessage());
        }
        j.setMsg(message);
        return j;
    }


    /**
     * 导入功能跳转
     *
     * @return
     */
    @RequestMapping(params = "upload")
    public ModelAndView upload(HttpServletRequest req) {
        req.setAttribute("controller_name", "keysignatureController");
        return new ModelAndView("common/upload/pub_excel_upload");
    }

    /**
     * 导出excel
     *
     * @param request
     * @param response
     */
    @RequestMapping(params = "exportXls")
    public String exportXls(KeysignatureEntity keysignature, HttpServletRequest request, HttpServletResponse response
            , DataGrid dataGrid, ModelMap modelMap) {
        CriteriaQuery cq = new CriteriaQuery(KeysignatureEntity.class, dataGrid);
        org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, keysignature, request.getParameterMap());
        List<KeysignatureEntity> keysignatures = this.keysignatureService.getListByCriteriaQuery(cq, false);
        modelMap.put(NormalExcelConstants.FILE_NAME, "密钥签名授权");
        modelMap.put(NormalExcelConstants.CLASS, KeysignatureEntity.class);
        modelMap.put(NormalExcelConstants.PARAMS, new ExportParams("密钥签名授权列表", "导出人:" + ResourceUtil.getSessionUser().getRealName(),
                "导出信息"));
        modelMap.put(NormalExcelConstants.DATA_LIST, keysignatures);
        return NormalExcelConstants.JEECG_EXCEL_VIEW;
    }

    /**
     * 导出excel 使模板
     *
     * @param request
     * @param response
     */
    @RequestMapping(params = "exportXlsByT")
    public String exportXlsByT(KeysignatureEntity keysignature, HttpServletRequest request, HttpServletResponse response
            , DataGrid dataGrid, ModelMap modelMap) {
        modelMap.put(NormalExcelConstants.FILE_NAME, "密钥签名授权");
        modelMap.put(NormalExcelConstants.CLASS, KeysignatureEntity.class);
        modelMap.put(NormalExcelConstants.PARAMS, new ExportParams("密钥签名授权列表", "导出人:" + ResourceUtil.getSessionUser().getRealName(),
                "导出信息"));
        modelMap.put(NormalExcelConstants.DATA_LIST, new ArrayList());
        return NormalExcelConstants.JEECG_EXCEL_VIEW;
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(params = "importExcel", method = RequestMethod.POST)
    @ResponseBody
    public AjaxJson importExcel(HttpServletRequest request, HttpServletResponse response) {
        AjaxJson j = new AjaxJson();

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
            MultipartFile file = entity.getValue();// 获取上传文件对象
            ImportParams params = new ImportParams();
            params.setTitleRows(2);
            params.setHeadRows(1);
            params.setNeedSave(true);
            try {
                List<KeysignatureEntity> listKeysignatureEntitys = ExcelImportUtil.importExcel(file.getInputStream(), KeysignatureEntity.class, params);
                for (KeysignatureEntity keysignature : listKeysignatureEntitys) {
                    keysignatureService.save(keysignature);
                }
                j.setMsg("文件导入成功！");
            } catch (Exception e) {
                j.setMsg("文件导入失败！");
                logger.error(e.getMessage());
            } finally {
                try {
                    file.getInputStream().close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return j;
    }


}
