package com.easycms.service.impl.user;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.easycms.base.AbstractBaseDao;
import com.easycms.common.Pager;
import com.easycms.entity.user.CmsUserExperterProjInfo;
import com.easycms.service.user.CmsUserExperterProjInfoService;

@Service
public class CmsUserExperterProjInfoServiceImpl extends AbstractBaseDao<CmsUserExperterProjInfo, Long> implements
		CmsUserExperterProjInfoService {


	@Override
	public void saveUserExperterProjInfo(CmsUserExperterProjInfo info) {
		// TODO Auto-generated method stub
		save(info);

	}

	@Override
	public CmsUserExperterProjInfo findUserExperterProjInfoById(long id) {
		// TODO Auto-generated method stub
		CmsUserExperterProjInfo cUserExperterProjInfo = findById(id);
		return cUserExperterProjInfo;
	}

	@Override
	public void updateUserExperterProjInfo(CmsUserExperterProjInfo info) {
		// TODO Auto-generated method stub
		update(info);
	}

	@Override
	public Pager<CmsUserExperterProjInfo> findUserExperterProjInfosByKey(Map<String, Object> map,
			int showPages, int pageSize) {
		// TODO Auto-generated method stub
		map.put("showPages", showPages);
		map.put("pageSize", pageSize);
		return findByKey(map, ".findByKey");
	}

	@Override
	public void deleteUserExperterProjInfoById(long id) {
		// TODO Auto-generated method stub
		delete(id);
	}
}

