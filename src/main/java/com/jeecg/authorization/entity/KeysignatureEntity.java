package com.jeecg.authorization.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.lang.String;
import java.io.UnsupportedEncodingException;
import java.lang.Double;
import java.lang.Integer;
import java.math.BigDecimal;
import javax.xml.soap.Text;
import java.sql.Blob;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;
import javax.persistence.SequenceGenerator;
import org.jeecgframework.poi.excel.annotation.Excel;

/**   
 * @Title: Entity
 * @Description: 密钥签名授权
 * @author onlineGenerator
 * @date 2020-04-23 17:28:41
 * @version V1.0   
 *
 */
@Entity
@Table(name = "keySignature", schema = "")
@SuppressWarnings("serial")
public class KeysignatureEntity implements java.io.Serializable {
	/**主键*/
	private java.lang.String id;
	/**创建人名称*/
	private java.lang.String createName;
	/**创建人登录名称*/
	private java.lang.String createBy;
	/**创建日期*/
	private java.util.Date createDate;
	/**更新人名称*/
	private java.lang.String updateName;
	/**更新人登录名称*/
	private java.lang.String updateBy;
	/**更新日期*/
	private java.util.Date updateDate;
	/**用户名称*/
	@Excel(name="用户名称",width=15)
	private java.lang.String userName;
	/**截止时间*/
	@Excel(name="截止时间",width=15)
	private java.lang.String byTime;
	/**授权模块*/
	@Excel(name="授权模块",width=15)
	private java.lang.String authorizationModule;
	/**明文*/
	@Excel(name="明文",width=15)
	private java.lang.String clear;
	/**密文*/
	@Excel(name="密文",width=15)
	private java.lang.String cipher;
	/**公钥*/
	@Excel(name="公钥",width=15)
	private java.lang.String publicKey;
	/**私钥*/
	@Excel(name="私钥",width=15)
	private java.lang.String privateKey;
	/**签名*/
	//@Excel(name="签名",width=15)
	private java.lang.String signature;




	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  主键
	 */
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")

	@Column(name ="ID",nullable=false,length=36)
	public java.lang.String getId(){
		return this.id;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  主键
	 */
	public void setId(java.lang.String id){
		this.id = id;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人名称
	 */

	@Column(name ="CREATE_NAME",nullable=true,length=50)
	public java.lang.String getCreateName(){
		return this.createName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  创建人名称
	 */
	public void setCreateName(java.lang.String createName){
		this.createName = createName;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人登录名称
	 */

	@Column(name ="CREATE_BY",nullable=true,length=50)
	public java.lang.String getCreateBy(){
		return this.createBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  创建人登录名称
	 */
	public void setCreateBy(java.lang.String createBy){
		this.createBy = createBy;
	}
	
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  创建日期
	 */

	@Column(name ="CREATE_DATE",nullable=true,length=20)
	public java.util.Date getCreateDate(){
		return this.createDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  创建日期
	 */
	public void setCreateDate(java.util.Date createDate){
		this.createDate = createDate;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  更新人名称
	 */

	@Column(name ="UPDATE_NAME",nullable=true,length=50)
	public java.lang.String getUpdateName(){
		return this.updateName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  更新人名称
	 */
	public void setUpdateName(java.lang.String updateName){
		this.updateName = updateName;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  更新人登录名称
	 */

	@Column(name ="UPDATE_BY",nullable=true,length=50)
	public java.lang.String getUpdateBy(){
		return this.updateBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  更新人登录名称
	 */
	public void setUpdateBy(java.lang.String updateBy){
		this.updateBy = updateBy;
	}
	
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  更新日期
	 */

	@Column(name ="UPDATE_DATE",nullable=true,length=20)
	public java.util.Date getUpdateDate(){
		return this.updateDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  更新日期
	 */
	public void setUpdateDate(java.util.Date updateDate){
		this.updateDate = updateDate;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  公钥
	 */

	@Column(name ="PUBLIC_KEY",nullable=true,length=320)
	public java.lang.String getPublicKey(){
		return this.publicKey;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  公钥
	 */
	public void setPublicKey(java.lang.String publicKey){
		this.publicKey = publicKey;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  私钥
	 */

	@Column(name ="PRIVATE_KEY",nullable=true,length=320)
	public java.lang.String getPrivateKey(){
		return this.privateKey;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  私钥
	 */
	public void setPrivateKey(java.lang.String privateKey){
		this.privateKey = privateKey;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  用户名称
	 */

	@Column(name ="USER_NAME",nullable=true,length=32)
	public java.lang.String getUserName(){
		return this.userName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  用户名称
	 */
	public void setUserName(java.lang.String userName){
		this.userName = userName;
	}
	
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  截止时间
	 */

	@Column(name ="BY_TIME",nullable=true,length=32)
	public java.lang.String getByTime(){
		return this.byTime;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  截止时间
	 */
	public void setByTime(java.lang.String byTime){
		this.byTime = byTime;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  授权模块
	 */

	@Column(name ="AUTHORIZATION_MODULE",nullable=true,length=320)
	public java.lang.String getAuthorizationModule(){
		return this.authorizationModule;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  授权模块
	 */
	public void setAuthorizationModule(java.lang.String authorizationModule){
		this.authorizationModule = authorizationModule;
	}


	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  签名
	 */

	@Column(name ="SIGNATURE",nullable=true,length=320)
	public java.lang.String getSignature(){
		return this.signature;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  签名
	 */
	public void setSignature(java.lang.String signature){
		this.signature = signature;
	}

	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  明文
	 */

	@Column(name ="CLEAR",nullable=true,length=320)
	public java.lang.String getClear(){
		return this.clear;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  明文
	 */
	public void setClear(java.lang.String clear){
		this.clear = clear;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  密文
	 */

	@Column(name ="CIPHER",nullable=true,length=320)
	public java.lang.String getCipher(){
		return this.cipher;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  密文
	 */
	public void setCipher(java.lang.String cipher){
		this.cipher = cipher;
	}
	
}
