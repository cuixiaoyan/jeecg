package com.jeecg.authorizedmenu.entity;

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
 * @Description: 授权菜单
 * @author onlineGenerator
 * @date 2020-04-27 17:09:35
 * @version V1.0   
 *
 */
@Entity
@Table(name = "authorizedMenu", schema = "")
@SuppressWarnings("serial")
public class AuthorizedmenuEntity implements java.io.Serializable {
	/**主键*/
	private java.lang.String id;
	/**菜单排序*/
	@Excel(name="菜单排序",width=15,dicCode="bpm_status")
	private java.lang.String sortMenu;
	/**创建人名称*/
	private java.lang.String createName;
	/**创建人登录名称*/
	private java.lang.String createBy;
	/**更新人名称*/
	private java.lang.String updateName;
	/**更新人登录名称*/
	private java.lang.String updateBy;
	/**菜单名称*/
	@Excel(name="菜单名称",width=15)
	private java.lang.String nameTheMenu;
	/**菜单编号*/
	@Excel(name="菜单编号",width=15)
	private java.lang.String menuNumber;
	/**创建日期*/
	private java.util.Date createDate;
	/**更新日期*/
	private java.util.Date updateDate;
	
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
	 *@return: java.lang.String  菜单排序
	 */

	@Column(name ="SORT_MENU",nullable=true,length=50)
	public java.lang.String getSortMenu(){
		return this.sortMenu;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  菜单排序
	 */
	public void setSortMenu(java.lang.String sortMenu){
		this.sortMenu = sortMenu;
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
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  菜单名称
	 */

	@Column(name ="NAME_THE_MENU",nullable=true,length=50)
	public java.lang.String getNameTheMenu(){
		return this.nameTheMenu;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  菜单名称
	 */
	public void setNameTheMenu(java.lang.String nameTheMenu){
		this.nameTheMenu = nameTheMenu;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  菜单编号
	 */

	@Column(name ="MENU_NUMBER",nullable=true,length=50)
	public java.lang.String getMenuNumber(){
		return this.menuNumber;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  菜单编号
	 */
	public void setMenuNumber(java.lang.String menuNumber){
		this.menuNumber = menuNumber;
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
	
}
